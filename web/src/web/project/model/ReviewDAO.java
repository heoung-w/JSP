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


import web.project.model.ReviewDTO;

public class ReviewDAO {
	private Connection conn=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	
	private static ReviewDAO instance=new ReviewDAO();
	private ReviewDAO() {}
	public static ReviewDAO getInstance() {
		return instance;
	}
	private Connection getConnection() throws Exception{
		Context ctx=new InitialContext();
		Context env=(Context)ctx.lookup("java:comp/env");
		DataSource ds=(DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	//리뷰 등록하는 메서드
	public int insertReview(ReviewDTO review) {
		String sql="";
			try{
				conn=getConnection();
				sql="insert into book_review values(book_review_seq.nextVal,?,?,?,?,?,sysdate)";
				pstmt=conn.prepareStatement(sql);
				
				pstmt.setString(1, review.getId());
				pstmt.setInt(2, review.getBk_num());
				pstmt.setString(3, review.getRecontent());
				pstmt.setString(4, review.getStar());
				pstmt.setInt(5, review.getRead_recount());
				
				return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs !=null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
			return 0;
	}
	//각 책 당 등록된 리뷰 개수 세는 메서드
	public int getReviewCount(int num) {
		int x = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from book_review where bk_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
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
	//리뷰 테이블에 담긴 리뷰 리스트 정보 가져오는 메서드
	public List getReviews(int start, int end, int num) {//리뷰 리스트 전체 가져오는 메서드
		List reviewList = null;
		try {
			conn = getConnection();
			String sql = "select bk_renum,bk_id,bk_num,bk_recontent,bk_star,bk_read_recount,bk_rereg,r "
					+ "from (select bk_renum,bk_id,bk_num,bk_recontent,bk_star,bk_read_recount,bk_rereg,rownum r "
					+ "from (select bk_renum,bk_id,bk_num,bk_recontent,bk_star,bk_read_recount,bk_rereg "
					+ "from book_review where bk_num = "+num+" order by bk_renum desc) order by bk_renum desc) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				reviewList = new ArrayList(end);
				do {
					ReviewDTO review = new ReviewDTO();
					review.setNum(rs.getInt("bk_renum"));
					review.setId(rs.getString("bk_id"));
					review.setBk_num(rs.getInt("bk_num"));
					review.setRecontent(rs.getString("bk_recontent"));
					review.setStar(rs.getString("bk_star"));
					review.setRead_recount(rs.getInt("bk_read_recount"));
					review.setBk_rereg(rs.getTimestamp("bk_rereg"));
					reviewList.add(review);
					System.out.println("리스트 review dao에꺼내기"+rs.getInt("bk_num"));
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(SQLException s) {}
			if(pstmt != null) try { pstmt.close(); }catch(SQLException s) {}
			if(conn != null) try { conn.close(); }catch(SQLException s) {}
		}
		return reviewList;
	}
	
	//지정한 리뷰 가져오기 
	public ReviewDTO getReview(int num) {
		ReviewDTO review = null;
		try {
			conn = getConnection();
			// 먼저 조회수 올려서 저장하기
			String sql = "update book_review set bk_read_recount = bk_read_recount + 1 where bk_renum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			// 다시 해당 리뷰 번호의 전체 데이터 가져오기
			sql = "select * from book_review where bk_renum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				review = new ReviewDTO();
				review.setNum(rs.getInt("bk_renum"));
				review.setId(rs.getString("bk_id"));
				review.setBk_num(rs.getInt("bk_num"));
				review.setRecontent(rs.getString("bk_recontent"));
				review.setStar(rs.getString("bk_star"));
				review.setRead_recount(rs.getInt("bk_read_recount"));
				review.setBk_rereg(rs.getTimestamp("bk_rereg"));
			}	
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return review;
	}
	//리뷰 삭제 메서드
	public void deleteReview(int num) {
		try {
			conn = getConnection();
			String sql = "delete from book_review where bk_renum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			//System.out.println(num+"리뷰 고유 번호.......");
			pstmt.executeQuery();	
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); }catch(SQLException s) {}
			if(conn != null) try { conn.close(); }catch(SQLException s) {}
		}
	}
	
	//리뷰 수정 메서드
	public void updateReview(ReviewDTO review) {
		try {
			conn=getConnection();
			String sql = "update book_review set bk_recontent=?,bk_star=? where bk_renum = ?";
			pstmt = conn.prepareStatement(sql);
				
			pstmt.setString(1, review.getRecontent());
				System.out.println(review.getRecontent()+"수정 메서드에서 수정할 리뷰 내용 받았는 지");
				
			pstmt.setString(2, review.getStar());
				System.out.println(review.getStar()+"수정 메서드에서 수정할 리뷰 star 받았는 지");
				
			pstmt.setInt(3, review.getNum());
				System.out.println(review.getNum()+"수정 메서드에서 수정할 리뷰 고유번호 받았는 지");
				
			pstmt.executeUpdate();	
				
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); }catch(SQLException s) {}
			if(conn != null) try { conn.close(); }catch(SQLException s) {}
		}	
	}
	//해당 아이디의 전체 리뷰 개수 가져오기
	public int getMyReviewCount(String id) {
		int x = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from book_review where bk_id= ?";
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

	//해당 아이디의 전체 리뷰 가져오기	
	public List getMyReviews(int start, int end, String id) {
		List reviewList = null;
		try {
			conn = getConnection();
			String sql = "select bk_renum,bk_id,bk_num,bk_recontent,bk_star,bk_read_recount,bk_rereg,r "
					+ "from (select bk_renum,bk_id,bk_num,bk_recontent,bk_star,bk_read_recount,bk_rereg,rownum r "
					+ "from (select * from book_review where bk_id = ? order by bk_renum desc) order by bk_renum desc) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				reviewList = new ArrayList();
				do {
					ReviewDTO review= new ReviewDTO();
					review.setNum(rs.getInt("bk_renum"));
					review.setId(rs.getString("bk_id"));
					review.setBk_num(rs.getInt("bk_num"));
					review.setRecontent(rs.getString("bk_recontent"));
					review.setStar(rs.getString("bk_star"));
					review.setRead_recount(rs.getInt("bk_read_recount"));
					review.setBk_rereg(rs.getTimestamp("bk_rereg"));
					reviewList.add(review);
				}while(rs.next());
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(SQLException s) {}
			if(pstmt != null) try { pstmt.close(); }catch(SQLException s) {}
			if(conn != null) try { conn.close(); }catch(SQLException s) {}
		}
		return reviewList;
	}
	
}
