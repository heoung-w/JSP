package web.boardView.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	// 글 저장 메서드
	public void insertArticle(BoardDTO article) {
		// 조정, 확인이 필요한 값들 꺼내기
		int num = article.getNum();				// 글번호(새글작성 0, 댓글이면 1이상)
		int ref = article.getRef();				// 글 그룹 1
		int re_step = article.getRe_step();		// 정렬 순서 0
		int re_level = article.getRe_level();	// 답글 레벨 0
		int number = 0;							// DB에 저장할 글 고유 번호
		String sql = "";
		try {
			conn = getConnection();
			// DB에서 가장 큰 글 고유번호 가져오기(num컬럼=글고유번호)
			pstmt = conn.prepareStatement("select max(num) from board");
			rs = pstmt.executeQuery();
			// 게시글이 존재하면, 가져온 num컬럼의 가장 큰수에 1을 더해서 number에 담기.
			if(rs.next()) number = rs.getInt(1) + 1;
			else number = 1;		// 게시글이 없으면 1번으로 지정. 
			
			// 답글일경우
			if(num != 0) {
				// DB에 기존에 달린 답글(re_step 0보다큰)이 있다면, 새답글이 1이 되기 위해
				// 해당글의 ref의 모든 답글의 step을 +1해라. 
				sql="update board set re_step=re_step+1 where ref=? and re_step>?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				// 답글은 DB에 저장하기 전에, 받아온 초기값 0에서 1이 되게 더해줌. 
				re_step += 1;
				re_level += 1;
			}else {
				// 새글일경우
				ref = number;	// 글 그룹번호와 글 고유 번호를 동일하게 
				re_step = 0;
				re_level = 0;
			}
			
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
			pstmt.setInt(9, re_step);
			pstmt.setInt(10, re_level);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		
	}//insertArticle닫기
	
	// 게시판 글 전체 개수 돌려주는 메서드
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
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return x;
	}
	
	// 게시글들 리턴해주는 메서드
	public List getArticles(int start, int end) {
		List articleList = null;
		try {
			conn = getConnection();
			String sql = "select num,writer,subject,email,content,pw,reg,readcount,ip,ref,re_step,re_level,r "
					+ "from (select num,writer,subject,email,content,pw,reg,readcount,ip,ref,re_step,re_level,rownum r "
					+ "from (select num,writer,subject,email,content,pw,reg,readcount,ip,ref,re_step,re_level "
					+ "from board order by ref desc, re_step asc) order by ref desc, re_step asc) "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				// 게시글 목록 list 
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
					articleList.add(article);	// 리스트 한개의 글을 DTO 단위로 추가 
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return articleList;
	}
	
	// 지정한 글 한개만 가져오는 메서드
	public BoardDTO getArticle(int num) {
		BoardDTO article = null;
		try {
			conn = getConnection();
			// 먼저 조회수 올려서 저장하기
			String sql = "update board set readcount=readcount+1 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			// 다시 해당 글번호의 전체 데이터 가져오기
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
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return article;
	}
	
	// 게시판 글 수정 메서드
	public int updateArticle(BoardDTO article) {
		int x = -1;			// 1 : 수정완료, 0 : 비번오기입, -1 : 메서드내 다른 오류
		String dbpw = "";
		try {
			conn = getConnection();
			// 비번 확인 (dbpw와 넘겨받은 article안에 있는 pw <--사용자입력한 비번 서로 비교확인)
			String sql = "select pw from board where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpw = rs.getString("pw");
				// 비번 확인되면 글 수정
				if(dbpw.equals(article.getPw())) {
					sql = "update board set writer=?,subject=?,email=?,content=? where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, article.getWriter());
					pstmt.setString(2, article.getSubject());
					pstmt.setString(3, article.getEmail());
					pstmt.setString(4, article.getContent());
					pstmt.setInt(5, article.getNum());
					pstmt.executeUpdate();
					x = 1;	// 글 수정 완료
				}else {
					x = 0;	// 비번 불일치
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return x;
	}
	
	// 글 삭제 메서드
	public int deleteArticle(int num, String pw) {
		int x = -1;
		String dbpw = "";
		try {
			conn = getConnection();
			String sql = "select pw from board where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpw = rs.getString("pw");
				if(dbpw.equals(pw)) {
					sql = "delete from board where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					x = 1;
				}else {
					x = 0;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return x;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
