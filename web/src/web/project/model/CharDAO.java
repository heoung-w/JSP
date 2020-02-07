package web.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CharDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private DataSource ds = null;
	
	private static CharDAO instance = new CharDAO();
	private CharDAO() {}
	public static CharDAO getInstance() {
		return instance;
	}
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		ds= (DataSource)ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}
	
	public void InsertCharList(String num, String id, int price) {
		try {
			conn = getConnection();
			String sql = "insert into book_mychar values(book_mychar_seq.nextVal,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.setString(2, id);
			pstmt.setInt(3, price);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}

		}		
	}
	
	public int CharList() {
		int total = 0;
		try {
			conn = getConnection();
			String sql = "select bk_price from book_mychar";
			pstmt = conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				total += rs.getInt("bk_price");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return total;
	}
	
	public int MonthCharList(int i) {
		int price = 0;
		String sql = "";
		try {
			conn = getConnection();
			sql = "select bk_price from book_mychar where bk_reg between concat('2020-',?||'-01') and concat('2020-',?+1||'-01')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, String.valueOf(i));
			pstmt.setString(2, String.valueOf(i));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				price += rs.getInt("bk_price");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return price;
	}
	
	
}
