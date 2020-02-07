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

import web.project.model.MemberDTO;

public class MemberDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private DataSource ds = null;
	
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		ds= (DataSource)ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}
	
	public void close(Connection conn,PreparedStatement pstmt,ResultSet rs) {
		
		if(rs!=null) {
			try {
				rs.close();
			}
			catch(SQLException e){
				e.printStackTrace();
			}
		}
		if(pstmt!=null) {
			try {
				pstmt.close();
			}
			catch(SQLException e){
				e.printStackTrace();
			}
		}
		if(conn!=null) {
			try {
				conn.close();
			}
			catch(SQLException e){
				e.printStackTrace();
			}
		
		}
	}
	
	// 회원가입 메서드
	public void insertMember(MemberDTO member) {
		try {
			conn = getConnection();
			String sql = "insert into book_member values(?,?,?,?,?,?,?,sysdate,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPw());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getPhone());
			pstmt.setString(5, member.getEmail());
			pstmt.setInt(6, member.getMoney());
			pstmt.setString(7, member.getCart());
			pstmt.setString(8, member.getBuylist());
			pstmt.executeUpdate();

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {}
			if(conn != null)try {conn.close();}catch(SQLException e) {}
		}
	}
	
	// 아이디 중복 확인 메서드
	public boolean mConfirmId(String id) {
		boolean check = false;
		try {			
			conn = getConnection();
			String sql = "select bk_id from book_member where bk_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				check = true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		
		return check;
	}
	
	
	// 로그인 메서드
	public boolean mLoginCheck(String id ,String pw) {
		boolean check = false;
		try {
			conn = getConnection();
			String sql = "select * from book_member where bk_id=? and bk_pw=?";
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
	
	// 지정한 회원정보 가져오기
	public MemberDTO getMember(String id) {
		MemberDTO member = null;
		try {
			conn = getConnection();
			String sql = "select * from book_member where bk_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new MemberDTO();
				member.setId(rs.getString("bk_id"));
				member.setPw(rs.getString("bk_pw"));
				member.setName(rs.getString("bk_name"));
				member.setPhone(rs.getString("bk_phone"));
				member.setEmail(rs.getString("bk_email"));
				member.setMoney(rs.getInt("bk_money"));
				member.setBuylist(rs.getString("bk_buylist"));
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
	
	
	
	
	// 회원정보 수정 메서드
	
	public void updateMember(MemberDTO member) {	
		try {
			conn = getConnection();
			String sql = "update book_member set bk_pw=?, bk_phone=?, bk_email=? where bk_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPw());
			pstmt.setString(2, member.getPhone());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getId());
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {}
			if(conn != null)try {conn.close();}catch(SQLException e) {}
		}
	}
	
	// 회원 탈퇴 메서드
		public int deleteMember(String id, String pw) {
			int x = -1;			// id가 일치 하지 않는 경우 
			String dbpw = "";
			try {
				conn = getConnection();
				// DB에서 해당 id의 비번 가져오기
				String sql = "select bk_pw from book_member where bk_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				
				rs = pstmt.executeQuery();
				if(rs.next()) {		// db에서 꺼내온 pw가 있다면, 커서를 가르키고
					dbpw = rs.getString("bk_pw");
					if(dbpw.equals(pw)) { // 비번이 서로 일치하면
						// 회원정보 삭제
						sql = "delete from book_member where bk_id=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, id);
						pstmt.executeUpdate();
						x = 1;	// 회원 탈퇴 성공
					}else {  // 비번이 서로 일치하지 않을 경우
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
	
		//책 장바구니에 저장하는 메소드
		public void addBook(String id, String num) {
			String number= num + ",";
			String bk_cart = null;
			try {
				conn = getConnection();
				
				String sql = "select bk_cart from book_member where bk_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) { 
					bk_cart = rs.getString(1);
					if(bk_cart == null) {
						bk_cart = "," + number;
					}else {
						bk_cart = bk_cart + number;
					}
				}
				
				sql = "update book_member set bk_cart= ? where bk_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, bk_cart);
				pstmt.setString(2, id);
				pstmt.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
				if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
				if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
			}
			
			
		}
		
		// 회원 장바구니에 담긴걸 꺼내오는 메서드
		public String getCart(String id) {
			String book_cart = null;
			try {
				conn = getConnection();
				String sql = "select bk_cart from book_member where bk_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					book_cart = rs.getString("bk_cart");
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(conn, pstmt, rs);
			}
			
			return book_cart; 
		}
		
		
		
		//장바구니 삭제 메서드
		public void deleteCart(String num) {
			try {
				conn = getConnection();
				String sql = "delete bk_cart "
						+ "from book_member where bk_cart like '%,"+num+",%'";
				pstmt = conn.prepareStatement(sql);
				pstmt.executeQuery();
 
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
				if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
			}	
		}
		
		
		// 책이 삭제되면 회원들이 가지고있는 장바구니 목록에서도 삭제 시켜줘야하기 떄문에
		// 삭제된 책에 고유 넘버를 받아와 모든 회원에 장바구니에서 지워줘야함
			
		public void deleteMemberCart(String num) {
			String sql = "";
			String id = null;
			String cart = null;
			String [] books = null;
			String newCart = null;
			
			try {
				conn = getConnection();
				sql = "select * from book_member where bk_cart like '%,"+num+",%'";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					id = rs.getString("BK_Id");
					cart = rs.getString("BK_CART");
					books = cart.split(",");
					
					//지웠다
					for(int i = 0; i < books.length; i++) {
						if(books[i].equals(num)) {
							books[i] = null;
						}
					}
					
					// null이 아닐 경우에 newCart에 담는다.
					for(int i = 0; i < books.length; i++) {
						if(books[i] != null) {
							if(newCart == null) {
								newCart = books[i];
							}
							newCart += books[i]+",";
						}
					}
					if(newCart.equals(",")) {
						newCart = "";
					}										
					// db에 저장해준다.
					sql = "update book_member set bk_cart =? where bk_id =?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, newCart);
					pstmt.setString(2, id);
					pstmt.executeUpdate();					
				}			
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(conn, pstmt, rs);
			}
		}
		
		public void deleteMemberBuyList(String num) {
			String sql = "";
			String id = null;
			String cart = null;
			String [] books = null;
			String newCart = null;
			
			try {
				conn = getConnection();
				sql = "select * from book_member where bk_buylist like '%,"+num+",%'";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					id = rs.getString("BK_Id  ");
					cart = rs.getString("BK_BUYLIST");
					books = cart.split(",");
					
					//지웠다
					for(int i = 0; i < books.length; i++) {
						if(books[i].equals(num)) {
							books[i] = null;
						}
					}
					
					// null이 아닐 경우에 newCart에 담는다.
					for(int i = 0; i < books.length; i++) {
						if(books[i] != null) {
							if(newCart == null) {
								newCart = books[i];
							}
							newCart += books[i]+",";
						}
					}
					if(newCart.equals(",")) {
						newCart = "";
					}										
					// db에 저장해준다.
					sql = "update book_member set bk_buylist =? where bk_id =?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, newCart);
					pstmt.setString(2, id);
					pstmt.executeUpdate();					
				}			
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(conn, pstmt, rs);
			}
		}
		
		
		// 장바구니에서 리스트 삭제
		// 그 책에 고유넘버를 받아와 내 bk_cart컬럼에서 삭제
		public void myShopDeleteList(String id,String num) {
			String sql = "";
			String cart = null;
			String [] books = null;
			String newCart = null;
			try {
				conn = getConnection();
				sql = "select bk_cart from book_member where bk_id =? and bk_cart like '%,"+num+",%'";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					cart = rs.getString("bk_cart");
					books = cart.split(",");
					// 지우자
					for(int i =0; i < books.length; i++) {
						if(books[i].equals(num)) {
							books[i] = null;
						}
					}		
					for(int i=0; i < books.length; i++) {
						if(books[i] != null) {
							if(newCart == null) {
								newCart = books[i];
							}
							newCart += books[i]+",";
						}
					}
					if(newCart.equals(",")) {
						newCart = "";
					}
				}
				sql = "update book_member set bk_cart =? where bk_id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, newCart);
				pstmt.setString(2, id);
				pstmt.executeUpdate();				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(conn, pstmt, rs);
			}
		}

		
		// 내 포인트 충전시 업데이트
		public int updatePoint(String id,int point) {
			try {
				conn = getConnection();
				String sql = "update book_member set bk_money=bk_money+? where bk_id =?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, point);
				pstmt.setString(2, id);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(conn,pstmt,rs);
			}
			return 0;
		}
		
		
		// 책을 구매하면 회원 디비 구매내역 컬럼에 담아줄 메소드
		
		public void InsertBuyList(String id, String num) {
			String sql ="";
			String buyList = null;
			try {
				conn = getConnection();
				sql = "select bk_buyList from book_member where bk_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					buyList = rs.getString(1);
					if(buyList == null) {
						buyList = ","+num+",";
					}else {
						buyList = buyList+num+",";
					}
				}		
				sql = "update book_member set bk_buylist = ? where bk_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, buyList);
				pstmt.setString(2, id);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
				if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
			}
		}
		
		
		// 책을 구매한후에 내 포인트 차감후 디비에 저장 메소드
		public int downPoint(String id,int point) {
			try {
				conn = getConnection();
				String sql = "update book_member set bk_money=? where bk_id =?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, point);
				pstmt.setString(2, id);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(conn,pstmt,rs);
			}
			return 0;
		}

		
		//전체 회원수 돌려주기
				public int getMemberCount() {
					int x = 0; 
					try {
						conn = getConnection();
						String sql = "select count(*) from book_member";
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

				//전체 회원 리스트로 돌려주기
				public List getMemberList(int startRow, int endRow) {
					List memberList = null;
					try {
						conn = getConnection();
						String sql = "select bk_id,bk_pw,bk_name,bk_phone,bk_email,bk_money,bk_cart,bk_reg,r "
						+ "from (select bk_id,bk_pw,bk_name,bk_phone,bk_email,bk_money,bk_cart,bk_reg,rownum r "
						+ "from (select * from book_member))where r >= ? and r <= ?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, startRow);
						pstmt.setInt(2, endRow);
						rs = pstmt.executeQuery();
						if(rs.next()) {
							memberList = new ArrayList();
							do {
								MemberDTO member = new MemberDTO();
								member.setId(rs.getString("bk_id"));
								member.setPw(rs.getString("bk_pw"));
								member.setName(rs.getString("bk_name"));
								member.setPhone(rs.getString("bk_phone"));
								member.setEmail(rs.getString("bk_email"));
								member.setMoney(rs.getInt("bk_money"));
								member.setCart(rs.getString("bk_cart"));
								member.setReg(rs.getTimestamp("bk_reg"));
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
				
				//관리자용 전용 회원 정보 삭제
				public void deleteMemberByAdmin(String id) {
					try {
						conn = getConnection();
						String sql = "delete from book_member where bk_id = ?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, id);
						pstmt.executeQuery();
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(pstmt != null) try { pstmt.close(); }catch(SQLException s) {}
						if(conn != null) try { conn.close(); }catch(SQLException s) {}
					}
				}
				
		
		
		
		
	
		
		
		
		
}
		
		
		


	
	
	
	
	
	
	
	
	
	
	
	
	
	

