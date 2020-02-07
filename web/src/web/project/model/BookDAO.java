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

public class BookDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private static BookDAO instance = new BookDAO(); //3.instance 를 private 으로 생성 (보드 DAO 전체를 다 가져다 쓰게 되는 것)
	private BookDAO() {}; //4. 생성자가 private 이니까 클래스 밖에서는 객체 생성 못하게 막아버리는 이 메서드의 핵심
	public static BookDAO getInstance() { // 1. 메서드 호출
		return instance; //2. instance (자신의 객체) 를 리턴
	}
	
	
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	// 책 정보를 등록하는 메서드
	public void insertBook(BookDTO article) {
		int number = 0;
		String sql = "";
		try {
			conn = getConnection();
			sql = "insert into book_list values (book_list_seq.nextVal,?,?,?,?,?,?,?,?,sysdate,0)";			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,article.getName());
			pstmt.setString(2, article.getImg());
			pstmt.setInt(3, article.getPrice());
			pstmt.setString(4, article.getGenre());
			pstmt.setString(5, article.getWriter());
			pstmt.setString(6, article.getPublisher());
			pstmt.setString(7, article.getContent());
			pstmt.setString(8, article.getRegs());
			pstmt.executeUpdate();			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}		
	}
	
	
		// 게시판 글 전체 개수 돌려주는 메서드
	
		public int getArticleCount() {
			int x = 0;
			try {
				conn = getConnection();
				String sql = "select count(*) from book_list";
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
	
		
		
		// 테이블에 담겨져있는 책리스트 정보를 리턴해 주는 메서드
		
		public List getArticle(int start, int end) {
			List articleList = null;			
			try {
				conn = getConnection();
				String sql = "select bk_num,bk_name,bk_img,bk_price,bk_genre,bk_writer,bk_publisher,bk_regs,bk_read_count,r "
						+ "from (select bk_num,bk_name,bk_img,bk_price,bk_genre,bk_writer,bk_publisher,bk_regs,bk_read_count,rownum r "
						+ "from (select bk_num,bk_name,bk_img,bk_price,bk_genre,bk_writer,bk_publisher,bk_regs,bk_read_count "
						+ "from book_list order by bk_num desc) order by bk_num desc)  "
						+ "where r >= ? and r <= ?";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					articleList = new ArrayList();
					do {
						BookDTO article = new BookDTO();
						article.setNum(rs.getInt("bk_num"));
						article.setName(rs.getString("bk_name"));
						article.setImg(rs.getString("bk_img"));
						article.setPrice(rs.getInt("bk_price"));
						article.setGenre(rs.getString("bk_genre"));
						article.setWriter(rs.getString("bk_writer"));
						article.setPublisher(rs.getString("bk_publisher"));
						article.setRegs(rs.getString("bk_regs"));
						article.setReadcount(rs.getInt("bk_read_count"));
						
						articleList.add(article);	
						
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
		
	
		
		// 테이블에 담겨있는 장르별로 책리스트 개수를 리턴
		
		public int getGenreArticleCount(String genre) {
			int x = 0;
			try {
				conn = getConnection();
				String sql = "select count(*) from book_list where bk_genre = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, genre);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					x = rs.getInt(1);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
				if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
				if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
			}
			return x;
			
		}
		
		
		
		// 테이블에 담겨있는 genre(컬럼)에서 찾아 맞는 정보를 정렬해서 가져와라 
		
		public List getGenreArticle(String genre,int start, int end) {
			List articleList = null;
			
			try {
				conn = getConnection();
				String sql = "select bk_num,bk_name,bk_img,bk_price,bk_genre,bk_writer,bk_publisher,bk_regs,bk_read_count,r "
						+ "from (select bk_num,bk_name,bk_img,bk_price,bk_genre,bk_writer,bk_publisher,bk_regs,bk_read_count,rownum r "
						+ "from (select bk_num,bk_name,bk_img,bk_price,bk_genre,bk_writer,bk_publisher,bk_regs,bk_read_count "
						+ "from  book_list where bk_genre = ? order by bk_num desc) order by bk_num desc)  "
						+ "where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, genre);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				rs = pstmt.executeQuery();
				if(rs.next()){
					articleList = new ArrayList();
					do {
						BookDTO article = new BookDTO();
						article.setNum(rs.getInt("bk_num"));
						article.setName(rs.getString("bk_name"));
						article.setImg(rs.getString("bk_img"));
						article.setPrice(rs.getInt("bk_price"));
						article.setGenre(rs.getString("bk_genre"));
						article.setWriter(rs.getString("bk_writer"));
						article.setPublisher(rs.getString("bk_publisher"));
						article.setRegs(rs.getString("bk_regs"));
						article.setReadcount(rs.getInt("bk_read_count"));
						
						articleList.add(article);
						
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
			
	
		
		
		// 지정한 책 정보를 한개만 가져오는 메서드
		public BookDTO getArticle(int num) {
			BookDTO article = null;
			try {
				conn = getConnection();
				
				// 먼저 조회수 올려서 저장하기
				String sql = "update book_list set bk_read_count = bk_read_count + 1 where bk_num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
				
				// 다시 해당 글 번호의 전체 데이터 가져오기
				sql = "select * from book_list where bk_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					article = new BookDTO();
					article.setNum(rs.getInt("bk_num"));
					article.setName(rs.getString("bk_name"));
					article.setImg(rs.getString("bk_img"));
					article.setPrice(rs.getInt("bk_price"));
					article.setGenre(rs.getString("bk_genre"));
					article.setWriter(rs.getString("bk_writer"));
					article.setPublisher(rs.getString("bk_publisher"));
					article.setContent(rs.getString("bk_content"));
					article.setRegs(rs.getString("bk_regs"));
					article.setReg(rs.getTimestamp("bk_reg"));
					article.setReadcount(rs.getInt("bk_read_count"));
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
	
		
		// 책을 검색했을때 해당하는 글의 개수를 불러오는 메소드
		
		public int getSearchArticleCount(String sel, String search) {
			int count = 0;
				try {
					conn = getConnection();
					String sql = "select count(*) from book_list where "+sel+" like '%"+search+"%'";
					pstmt = conn.prepareStatement(sql);
					// pstmt.setString(1, search);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						count = rs.getInt(1);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
					if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
					if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
				}
			return count;
		}
		
		 
		// (제목,저자)검색했을때 해당 정보를 가져와줄 메소드
		public List getSearchArticles(String sel, String search,int start, int end) {
			List articleList = null;
			
			try {
				conn = getConnection();
				String sql = "select bk_num,bk_name,bk_img,bk_price,bk_genre,bk_writer,bk_publisher,bk_regs,bk_read_count,r "
						+ "from (select bk_num,bk_name,bk_img,bk_price,bk_genre,bk_writer,bk_publisher,bk_regs,bk_read_count,rownum r "
						+ "from (select bk_num,bk_name,bk_img,bk_price,bk_genre,bk_writer,bk_publisher,bk_regs,bk_read_count "
						+ "from book_list where "+sel+" like '%"+search+"%' order by bk_num desc) order by bk_num desc)  "
						+ "where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					articleList = new ArrayList();
					do {
						BookDTO article = new BookDTO();
						article.setNum(rs.getInt("bk_num"));
						article.setName(rs.getString("bk_name"));
						article.setImg(rs.getString("bk_img"));
						article.setPrice(rs.getInt("bk_price"));
						article.setGenre(rs.getString("bk_genre"));
						article.setWriter(rs.getString("bk_writer"));
						article.setPublisher(rs.getString("bk_publisher"));
						article.setRegs(rs.getString("bk_regs"));
						article.setReadcount(rs.getInt("bk_read_count"));
						articleList.add(article);
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
		
		
		// 책 정보를 수정 하는 메소드
		public void updateBook(BookDTO article) {
			try {
				conn = getConnection();
				String sql = "update book_list set bk_name=?,bk_img=?,bk_price=?,bk_genre=?,bk_publisher=?,bk_content=? where bk_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, article.getName());
				pstmt.setString(2, article.getImg());
				pstmt.setInt(3, article.getPrice());
				pstmt.setString(4, article.getGenre());
				pstmt.setString(5, article.getPublisher());
				pstmt.setString(6, article.getContent());
				pstmt.setInt(7, article.getNum());
				pstmt.executeUpdate();					
				}catch (Exception e){
				e.printStackTrace();
				}
				if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
				if(conn != null)try{conn.close();}catch(SQLException e) {e.printStackTrace();
				}
		}
		
		
		// 책 목록 삭제 하는 메소드
		public void deleteBookList(int num){
			try {
				conn = getConnection();
				String sql = "delete from book_list where bk_num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
				if(conn != null)try{conn.close();}catch(SQLException e) {e.printStackTrace();}
			}			
		}
		
		
		
		
		
		
	
		
		
		
		
		
		
		
		
		
		
		
		
}
		
		
		
