package web.jspsave.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UploadDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		
		return ds.getConnection();
	}
	
	public void uploadImg(String writer, String img) {
		try {
			conn = getConnection();
			String sql = "insert into upload values(?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, writer);
			pstmt.setString(2, img);
			pstmt.executeUpdate();
			
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
				
	}
	
	public List getImg(String writer) {
		List imgs = null;
		try {
			conn = getConnection();
			String sql = "select * from upload where writer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, writer);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				imgs = new ArrayList();
				do {
					imgs.add(rs.getString("img"));
				}while(rs.next());
				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if(pstmt != null)try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(rs != null)try{rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		
		return imgs;
	}
}
