package web.jspLast.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class MemberDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private static MemberDAO instance = new MemberDAO();
	private MemberDAO() {}
	public static MemberDAO getInstance() {
		return instance;
	}
	
	// 커넥션
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();						
		Context env = (Context)ctx.lookup("java:comp/env");		
		DataSource ds = (DataSource)env.lookup("jdbc/xe");		
		return ds.getConnection();
	}
	
	// 회원가입 v
	public void insertMember(MemberDTO dto) {
		try {
			conn = getConnection();
			String sql = "insert into imgMember values(?,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getBirth());
			pstmt.setString(5, dto.getEmail());			
			pstmt.setString(6, dto.getPhoto());			
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();}catch(SQLException s) {}
			if(conn != null) try {conn.close();}catch(SQLException s) {}
		}
	}
	
	// 로그인 확인 메서드 v
	public boolean loginCheck(String id, String pw) {
		boolean result = false;
		try {
			conn = getConnection();
			String sql = "select * from imgMember where id=? and pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(SQLException s) {}
			if(pstmt != null)try {pstmt.close();}catch(SQLException s) {}
			if(conn != null)try {conn.close();}catch(SQLException s) {}
		}
		return result;
	}
	
	// 지정 회원정보 가져오기 v
	public MemberDTO getMember(String id) {
		MemberDTO member = null;
		try {
			conn = getConnection();
			String sql = "select * from imgMember where id = ?";
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
		}finally{
			if(rs != null)try {rs.close();}catch(SQLException s) {}
			if(pstmt != null)try {pstmt.close();}catch(SQLException s) {}
			if(conn != null)try {conn.close();}catch(SQLException s) {}
		}
		return member;
	}
	
	// 회원정보 수정 v
	public void updateMember(MemberDTO member) {
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
		}finally{
			if(pstmt != null)try {pstmt.close();}catch(SQLException s) {}
			if(conn != null)try {conn.close();}catch(SQLException s) {}
		}
	}
	
	// 회원 탈퇴 v
	public int deleteMember(String id, String pw) {
		int x = -1;
		String dbpw = "";
		try {
			conn = getConnection();
			// DB에서 해당 id의 비번가져오기
			String sql = "select pw from imgMember where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpw = rs.getString("pw");
				// DB상 비번과 입력한 비번 비교확인 
				if(dbpw.equals(pw)) {
					// 회원정보삭제
					sql = "delete from imgMember where id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.executeQuery();
					x = 1;	// 회원탈퇴 성공
				}else {
					System.out.println("비번오류");
					x = 0;	// 비밀번호 오류
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if(rs != null)try {rs.close();}catch(SQLException s) {}
			if(pstmt != null)try {pstmt.close();}catch(SQLException s) {}
			if(conn != null)try {conn.close();}catch(SQLException s) {}
		}
		return x;
	}
	
	// id확인 v
	public int confirmId(String id) {
		int x = -1;
		try {
			conn = getConnection();
			String sql = "select id from imgMember where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = 1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(SQLException s) {}
			if(pstmt != null)try {pstmt.close();}catch(SQLException s) {}
			if(conn != null)try {conn.close();}catch(SQLException s) {}
		}
		return x;
	}
	
	// # jsp12 추가: 지정한 회원수 돌려주기
	public int getSearchMemberCount(String selector, String search) {
		int x = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from imgMember where "+selector+" like '%"+search+"%'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(SQLException s) {}
			if(pstmt != null)try {pstmt.close();}catch(SQLException s) {}
			if(conn != null)try {conn.close();}catch(SQLException s) {}
		}
		return x;
	}

	// # jsp12 추가: 전체 회원수 돌려주기
	public int getMemberCount() {
		int x = 0; 
		try {
			conn = getConnection();
			String sql = "select count(*) from imgMember";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(SQLException s) {}
			if(pstmt != null)try {pstmt.close();}catch(SQLException s) {}
			if(conn != null)try {conn.close();}catch(SQLException s) {}
		}
		return x;
	}
	// # jsp12 추가: 지정한 회원 리스트로 돌려주기
	public List getSearchMemberList(int startRow, int endRow, String selector, String search) {
		List memberList = null;
		try {
			conn = getConnection();
			String sql = "select id,pw,name,birth,email,photo,reg,r "
			+ "from (select id,pw,name,birth,email,photo,reg,rownum r "
			+ "from (select * from imgMember where "+selector+" like '%"+search+"%')) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				memberList = new ArrayList();
				do {
					MemberDTO member = new MemberDTO();
					member.setId(rs.getString("id"));
					member.setPw(rs.getString("pw"));
					member.setName(rs.getString("name"));
					member.setBirth(rs.getString("birth"));
					member.setEmail(rs.getString("email"));
					member.setPhoto(rs.getString("photo"));
					member.setReg(rs.getTimestamp("reg"));
					memberList.add(member);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(SQLException s) {}
			if(pstmt != null)try {pstmt.close();}catch(SQLException s) {}
			if(conn != null)try {conn.close();}catch(SQLException s) {}
		}
		return memberList;
	}
	// # jsp12 추가: 전체 회원 리스트로 돌려주기
	public List getMemberList(int startRow, int endRow) {
		List memberList = null;
		try {
			conn = getConnection();
			String sql = "select id,pw,name,birth,email,photo,reg,r "
			+ "from (select id,pw,name,birth,email,photo,reg,rownum r "
			+ "from (select * from imgMember)) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				memberList = new ArrayList();
				do {
					MemberDTO member = new MemberDTO();
					member.setId(rs.getString("id"));
					member.setPw(rs.getString("pw"));
					member.setName(rs.getString("name"));
					member.setBirth(rs.getString("birth"));
					member.setEmail(rs.getString("email"));
					member.setPhoto(rs.getString("photo"));
					member.setReg(rs.getTimestamp("reg"));
					memberList.add(member);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(SQLException s) {}
			if(pstmt != null)try {pstmt.close();}catch(SQLException s) {}
			if(conn != null)try {conn.close();}catch(SQLException s) {}
		}
		return memberList;
	}
	
}
