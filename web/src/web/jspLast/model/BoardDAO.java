package web.jspLast.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class BoardDAO {

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	private static BoardDAO instance = new BoardDAO();
	private BoardDAO() {}
	public static BoardDAO getInstance() {
		return instance;
	}
	
	private Connection getConnection() throws Exception  {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/xe");
		return ds.getConnection();
	}
	

	public int getArticleCount() {
		int x = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {				
				x = rs.getInt(1);		
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(SQLException s) {}
			if(pstmt != null) try { pstmt.close(); }catch(SQLException s) {}
			if(conn != null) try { conn.close(); }catch(SQLException s) {}
		}
		return x;
	}
	
	// 게시글들 (전체)가져오기
	public List getArticles(int start, int end) {
		List articleList = null;
		try {
			conn = getConnection();
			String sql = "select num,writer,subject,email,content,pw,reg,readcount,ip,ref,re_step,re_level,r "
					+ "from (select num,writer,subject,email,content,pw,reg,readcount,ip,ref,re_step,re_level,rownum r "
					+ "from (select num,writer,subject,email,content,pw,reg,readcount,ip,ref,re_step,re_level "
					+ "from board order by ref desc, re_step asc) order by ref desc, re_step asc) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				articleList = new ArrayList(end);
				do {
					BoardDTO article = new BoardDTO();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setSubject(rs.getString("subject"));
					article.setEmail(rs.getString("email"));
					article.setContent(rs.getString("content"));
					article.setPw(rs.getString("pw"));
					article.setReg(rs.getTimestamp("reg"));
					article.setReadcount(rs.getInt("readcount"));
					article.setIp(rs.getString("ip"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					articleList.add(article);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(SQLException s) {}
			if(pstmt != null) try { pstmt.close(); }catch(SQLException s) {}
			if(conn != null) try { conn.close(); }catch(SQLException s) {}
		}
		return articleList;
	}
	
	// 게시글 저장
	public void insertArticle(BoardDTO article) {
		// 조정,확인이 필요한 값들 꺼내기
		int num = article.getNum();					// 글번호(새글작성이면 0, 댓글일때 1이상)
		int ref = article.getRef();					// 글 그룹 1
		int re_step = article.getRe_step();			// 정렬 순서 0
		int re_level = article.getRe_level();		// 답글 레벨 0
		int number = 0;								// DB에 저장할 글 고유번호
		String sql = "";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select max(num) from board");	// 가장 큰 글고유번호 : num컬럼에 가장큰수
			rs = pstmt.executeQuery();
			if(rs.next()) number = rs.getInt(1) + 1;	// 게시글이 존재하면 가져온 제일큰 번호에 1을 더해 담아라.
			else number = 1;							// 게시글이 없으면 1번으로 지정.
			
			if(num != 0) { 	// #6.2답글 일때 
				sql = "update board set re_step=re_step+1 where ref = ? and re_step > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeQuery();
				// 답글은 DB에 저장하기전에, 받아온 초기값 0에서 1이 되게 더해줌.
				re_step = re_step+1;
				re_level = re_level+1;
			}else {			// #4 새 글작성 일때
				ref = number;		// 그룹번호와 글 고유번호를 동일하게
				re_step = 0; 		
				re_level = 0;
			}
			// readcount를 제외한 나머지를 저장해야해서 각각 지정
			sql = "insert into board(num,writer,subject,email,content,pw,reg,";
			sql += "ip,ref,re_step,re_level) values(board_seq.nextVal,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getSubject());
			pstmt.setString(3, article.getEmail());
			pstmt.setString(4, article.getContent());
			pstmt.setString(5, article.getPw());
			pstmt.setTimestamp(6, article.getReg());
			pstmt.setString(7, article.getIp());
			pstmt.setInt(8, ref);
			pstmt.setInt(9,	re_step);
			pstmt.setInt(10, re_level);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(SQLException s) {}
			if(pstmt != null) try { pstmt.close(); }catch(SQLException s) {}
			if(conn != null) try { conn.close(); }catch(SQLException s) {}
		}
	}
	
	// 지정한 게시글 가져오기
	public BoardDTO getArticle(int num) {
		BoardDTO article = null;
		try {
			conn = getConnection();
			// 먼저 조회수 올려서 저장하기
			String sql = "update board set readcount=readcount+1 where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeQuery();
			
			// 다시 해당번호 레코드 가져오기
			sql = "select * from board where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				article = new BoardDTO();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setSubject(rs.getString("subject"));
				article.setEmail(rs.getString("email"));
				article.setContent(rs.getString("content"));
				article.setPw(rs.getString("pw"));
				article.setReg(rs.getTimestamp("reg"));
				article.setReadcount(rs.getInt("readcount"));
				article.setIp(rs.getString("ip"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(SQLException s) {}
			if(pstmt != null) try { pstmt.close(); }catch(SQLException s) {}
			if(conn != null) try { conn.close(); }catch(SQLException s) {}
		}
		return article;
	}
	
	// 업데이트용 메서드
	public int updateArticle(BoardDTO article) {
		int x = -1;
		String dbpw = "";
		try {
			conn = getConnection();
			// 비번확인
			// 글 고유번호에 해당되는 pw를 db에서 가져오기
			String sql = "select pw from board where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpw = rs.getString("pw");
				if(dbpw.equals(article.getPw())) {
					sql = "update board set writer=?,subject=?,email=?,content=?,pw=? where num = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, article.getWriter());
					pstmt.setString(2, article.getSubject());
					pstmt.setString(3, article.getEmail());
					pstmt.setString(4, article.getContent());
					pstmt.setString(5, article.getPw());
					pstmt.setInt(6, article.getNum());
					pstmt.executeUpdate();
					x = 1;
				}else {	// 비번 틀림.
					x = 0;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(SQLException s) {}
			if(pstmt != null) try { pstmt.close(); }catch(SQLException s) {}
			if(conn != null) try { conn.close(); }catch(SQLException s) {}
		}
		return x;
	}
	
	// 게시글 삭제
	public int deleteArticle(int num, String pw) {
		int x = -1;
		String dbpw = "";
		try {
			conn = getConnection();
			String sql = "select pw from board where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpw = rs.getString("pw");
				if(dbpw.equals(pw)) {
					sql = "delete from board where num = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeQuery();
					x = 1;
				}else {
					x = 0;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(SQLException s) {}
			if(pstmt != null) try { pstmt.close(); }catch(SQLException s) {}
			if(conn != null) try { conn.close(); }catch(SQLException s) {}
		}
		return x;
	}
	
	// # 해당 아이디의 전체 글개수 가져오기 
	public int getMyArticleCount(String id) {
		int x = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from board where writer = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(SQLException s) {}
			if(pstmt != null) try { pstmt.close(); }catch(SQLException s) {}
			if(conn != null) try { conn.close(); }catch(SQLException s) {}
		}
		return x;
	}

	// # 해당 아이디의 전체 글 가져오기 (전체글가져오는것에서 조금만 수정)
	public List getMyArticles(int start, int end, String id) {
		List articleList = null;
		try {
			conn = getConnection();
			String sql = "select num,writer,subject,email,content,pw,reg,readcount,ip,ref,re_step,re_level,r "
					+ "from (select num,writer,subject,email,content,pw,reg,readcount,ip,ref,re_step,re_level,rownum r "
					+ "from (select * from board where writer = ? order by ref desc, re_step asc) order by ref desc, re_step asc) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				articleList = new ArrayList();
				do {
					BoardDTO article = new BoardDTO();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setSubject(rs.getString("subject"));
					article.setEmail(rs.getString("email"));
					article.setContent(rs.getString("content"));
					article.setPw(rs.getString("pw"));
					article.setReg(rs.getTimestamp("reg"));
					article.setReadcount(rs.getInt("readcount"));
					article.setIp(rs.getString("ip"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					articleList.add(article);
				}while(rs.next());
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(SQLException s) {}
			if(pstmt != null) try { pstmt.close(); }catch(SQLException s) {}
			if(conn != null) try { conn.close(); }catch(SQLException s) {}
		}
		return articleList;
	}
	
	
	// # 관리자 전용 게시글 삭제
	public void deleteArticleByAdmin(int num) {
		try {
			conn = getConnection();
			String sql = "delete from board where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeQuery();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); }catch(SQLException s) {}
			if(conn != null) try { conn.close(); }catch(SQLException s) {}
		}
	}
	
	// # 검색한 글 총 개수 돌려주기
	public int getSearchArticleCount(String sel, String search) {
		int x = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from board where "+sel+" like '%"+search+"%'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(SQLException s) {}
			if(pstmt != null) try { pstmt.close(); }catch(SQLException s) {}
			if(conn != null) try { conn.close(); }catch(SQLException s) {}
		}
		return x;
	}
	// # 검색한 글 리스트 돌려주기
	public List getSearchArticles(int startRow, int endRow, String sel, String search) {
		List articleList = null;
		try {
			conn = getConnection();
			String sql = "select num,writer,subject,email,content,pw,reg,readcount,ip,ref,re_step,re_level,r "
					+ "from (select num,writer,subject,email,content,pw,reg,readcount,ip,ref,re_step,re_level,rownum r "
					+ "from (select * from board where "+sel+" like '%"+search+"%' order by ref desc, re_step asc) "
					+ "order by ref desc, re_step asc) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				articleList = new ArrayList();
				do {
					BoardDTO article = new BoardDTO();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setSubject(rs.getString("subject"));
					article.setEmail(rs.getString("email"));
					article.setContent(rs.getString("content"));
					article.setPw(rs.getString("pw"));
					article.setReg(rs.getTimestamp("reg"));
					article.setReadcount(rs.getInt("readcount"));
					article.setIp(rs.getString("ip"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					articleList.add(article);
				}while(rs.next());
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(SQLException s) {}
			if(pstmt != null) try { pstmt.close(); }catch(SQLException s) {}
			if(conn != null) try { conn.close(); }catch(SQLException s) {}
		}
		return articleList;
	}
	
	// # 글 내용보기전에 비번 확인 메서드
	public boolean isContentPwCorrect(int num, String pw) {
		boolean res = false;
		String dbpw = "";
		try {
			conn = getConnection();
			String sql = "select pw from board where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpw = rs.getString("pw");
				if(pw.equals(dbpw)) {
					res = true;
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(SQLException s) {}
			if(pstmt != null) try { pstmt.close(); }catch(SQLException s) {}
			if(conn != null) try { conn.close(); }catch(SQLException s) {}
		}
		return res;
	}
	
	
	
	
	
	
	
	
	
	
}
