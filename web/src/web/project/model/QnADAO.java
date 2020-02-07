package web.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import web.project.model.*;

public class QnADAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private static QnADAO instance = new QnADAO(); // 3.instance 를 private 으로 생성 (보드 DAO 전체를 다 가져다 쓰게 되는 것)
	private QnADAO() {} //4. 생성자가 private 이니까 클래스 밖에서는 객체 생성 못하게 막아버리는 이 메서드의 핵심
	public static QnADAO getInstance() {  // 1. 메서드 호출
		return instance; //2. instance (자신의 객체) 를 리턴
	}
	
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	public void insertArticle(QnADTO article) {
		// 조정, 확인이 필요한 값 꺼내기
		int num = article.getNum();				// 글 번호(새글 0, 댓글 1이상)
		int number = 0;							// DB에 지정될 글 고정 번호
		
		try {
			conn = getConnection();
			// DB에서 가장 큰 글 고유 번호 가져오기 (num컬럼 = 글 고유 번호)
			pstmt = conn.prepareStatement("select max(num) from qna");
			rs = pstmt.executeQuery();
			// 게시글이 존재하면, 가져온  num컬럼의 가장 큰 수에 1을 더해서 number에 담기
			if(rs.next()) number = rs.getInt(1) + 1; 
			else number = 1;	// 게시클이 없으면 1번으로 지정
			
			String sql = "insert into qna(num, writer, title, email, content, reg) values("
					+ "qna_seq.nextval,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getTitle());
			pstmt.setString(3, article.getEmail());
			pstmt.setString(4, article.getContent());
			pstmt.setTimestamp(5, article.getReg());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
	} // 글 저장 메서드 종료
	
	// 게시판 글 전체계수 돌려주는 메서드
	public int getArticleCount() {
		int x = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from qna";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return x;
	} // 게시글 전체 계수 메서드 종료
	
	// 게시글 리턴해주는 메서드
	public List getArticles(int start, int end) {
		List articleList = null;
		try {
			conn = getConnection();
			String sql = "select num,writer,title,email,content,reg,read_count,r "
		               + "from (select num,writer,title,email,content,reg,read_count,rownum r "
		               + "from (select num,writer,title,email,content,reg,read_count "
		               + "from qna order by num desc) order by num desc) "
		               + "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				// articleList목록 list
				articleList = new ArrayList(end);
				do {
					QnADTO article = new QnADTO();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setTitle(rs.getString("title"));
					article.setEmail(rs.getString("email"));
					article.setContent(rs.getString("content"));
					article.setReg(rs.getTimestamp("reg"));
					article.setRead_count(rs.getInt("read_count"));
					articleList.add(article);	// 리스트 한 개의 
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return articleList;
	} // 리턴메서드 종료 
	
	// 글 한개만 가져오는 메서드
	public QnADTO getArticle(int num) {
		QnADTO article = null;
		try {
			conn = getConnection();
			// 먼저 조회수 올려서 저장하기
			String sql = "update qna set read_count=read_count+1 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			// 다시 해당 글 번호의 전체 데이터 가져오기
			sql = "select * from qna where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				article = new QnADTO();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setTitle(rs.getString("title"));
				article.setEmail(rs.getString("email"));
				article.setContent(rs.getString("content"));
				article.setReg(rs.getTimestamp("reg"));
				article.setRead_count(rs.getInt("read_count"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return article;
	} //
	
	// 게시판 수정 메서드
	public void updateArticle(QnADTO article) {
		try {
				conn = getConnection();
				String sql = "update qna set writer=?, title=?, email=?, content=? where num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, article.getWriter());
				pstmt.setString(2, article.getTitle());
				pstmt.setString(3, article.getEmail());
				pstmt.setString(4, article.getContent());
				pstmt.setInt(5, article.getNum());
				pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally{
				if(pstmt != null)try {pstmt.close();}catch(SQLException s) {}
				if(conn != null)try {conn.close();}catch(SQLException s) {}
			}
	} //
	
	// 글 삭제 메서드
	public void deleteArticle(QnADTO article) {
		try{
	        conn = getConnection();
	        String sql = "delete from qna where num=?";	
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, article.getNum());
	        pstmt.executeQuery();	   
	    }catch(Exception e) {
	    	e.printStackTrace();
	    }finally{
	    	if(rs != null)try{rs.close();}catch(SQLException e){}
	    	if(pstmt != null)try{pstmt.close();}catch(SQLException e){}
	        if(conn != null)try{conn.close();}catch(SQLException e){}
	    }
	}		
}
