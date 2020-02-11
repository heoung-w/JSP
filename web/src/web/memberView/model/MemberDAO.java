package web.memberView.model;

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
	
	// 싱글턴으로 변경
	private static MemberDAO instance = new MemberDAO();
	private MemberDAO() {}
	public static MemberDAO getInstance() {
		return instance;
	}
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	// 회원 가입 메서드
	public void insertMember(MemberDTO member) {
		try {
			conn = getConnection();
			String sql = "insert into imgMember values(?,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPw());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getBirth());
			pstmt.setString(5, member.getEmail());
			pstmt.setString(6, member.getPhoto());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {}
			if(conn != null)try {conn.close();}catch(SQLException e) {}
		}
	}
	
	// 로그인 확인 메서드 : id-pw 일치하는지 확인
	public boolean loginCheck(String id, String pw) {
		boolean check = false;
		try {
			conn = getConnection();
			String sql = "select * from imgMember where id=? and pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);		
			rs = pstmt.executeQuery();
			if(rs.next()) {
				check = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return check;
	}
	
	// 특정 회원 정보 가져오기
	public MemberDTO getMember(String id) {
		MemberDTO member = null;
		try {
			conn = getConnection();
			String sql = "select * from imgMember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new MemberDTO();
				member.setId(rs.getString("id"));
				member.setPw(rs.getString("pw"));
				member.setName(rs.getString("name"));
				member.setBirth(rs.getString("birth"));
				member.setEmail(rs.getString("email"));
				member.setPhoto(rs.getString("photo"));
				member.setReg(rs.getTimestamp("reg"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return member;
	}
	
	// 회원 정보 수정
	public void updateMember(MemberDTO member) {
		// 사진은 업데이트가 될지 안될지 모르는 상황이기 때문에
		// 업데이트를 하는 상황을 고려하여 쿼리문에서 무조건 업데이트하게 만든다
		// 이때, 업데이트를 안하는 경우 기존의 데이터를 보존하기 위해
		// form에서 숨겨 이전 데이터를 보내주고, 이전 데이터로 다시 쿼리문에 적용시킴.
		try {
			conn = getConnection();
			String sql = "update imgMember set pw=?, birth=?, email=?, photo=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPw());
			pstmt.setString(2, member.getBirth());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getPhoto());
			pstmt.setString(5, member.getId());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
	}
	
	// 회원 탈퇴 메서드
	public int deleteMember(String id, String pw) {
		int x = -1;			// id가 일치 하지 않는 경우 
		String dbpw = "";
		try {
			conn = getConnection();
			// DB에서 해당 id의 비번 가져오기
			String sql = "select pw from imgMember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {		// db에서 꺼내온 pw가 있다면, 커서를 가르키고
				dbpw = rs.getString("pw");
				if(dbpw.equals(pw)) { // 비번이 서로 일치하면
					// 회원정보 삭제
					sql = "delete from imgMember where id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					x = 1;	// 회원 탈퇴 성공
				}else {  // 비번이 서로 일치하지 않을 경우
					System.out.println("비번 오류");
					x = 0;	// 비밀번호 오류
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
	
	// id 존재여부 확인 메서드 (confirmId)
	public boolean confirmId(String id) {
		boolean check = false;
		try {
			conn = getConnection();
			String sql = "select id from imgMember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {	// 결과가 있으면, 
				// 이미 db에 동일한 id가 있다.
				check = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return check;
	}
	
	// 회원의 사진 이름 가져오는 메서드
	public String getPhotoName(String id) {
		String name = null;
		try {
			conn = getConnection();
			String sql = "select photo from imgMember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				name = rs.getString("photo");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return name;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
