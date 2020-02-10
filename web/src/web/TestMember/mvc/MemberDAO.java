package web.TestMember.mvc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private DataSource ds = null;
	
	private static MemberDAO instance = new MemberDAO();
	private MemberDAO() {};
	public static MemberDAO getInstance() {
		return instance;
	}
	
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		ds= (DataSource)ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}
	
	public boolean loginCheck(String id, String pw) {
		boolean check = false;
		try {
			conn = getConnection();
			String sql = "select * from test where id=? and pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				check = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		
		
		return check;
	}
	
	
}
