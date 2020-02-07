<%@page import="web.project.model.BookDTO"%>
<%@page import="web.project.model.BookDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>책 전체 리스트 페이지</title>
	<link href = "style3.css" rel ="stylesheet" type="text/css"/>
</head>
<jsp:include page="mHeader.jsp"/>
<%	request.setCharacterEncoding("UTF-8");
	// 한 페이지에 보여줄 게시글 수와
	//시간 출력시 포맷 설정해주는 객체 생성
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");

	// # 게시글 페이지 정보 담기.
	// 게시글 하단에 목록 페이지 번호 누를때마다 pageNum 파라미터 던져줄것임.
	// 여기서 받기
	String pageNum = null;
	if(request.getParameter("pageNum") != null){
		pageNum = request.getParameter("pageNum");
	}else{
		pageNum = "1";
	}
	
	int num = 0;
	if(request.getParameter("num") != null){
		num = Integer.parseInt(request.getParameter("num"));
	}
	String genre = null;
	if(request.getParameter("genre") != null){
		genre = request.getParameter("genre");
	}
	// 현재 페이지에 보여줄 게시글의 시작과 끝 등등 정보세팅
	// 현재 페이지
	int currentPage = Integer.parseInt(pageNum);
	int range = ((currentPage-1) * pageSize);
	// DB에 있는 게시글 총 개수 담을 변수, 0으로 초기화
	int count = 0;
	// 페이지 시작글 번호
	int startRow = 0;	
	// 페이지 끝 글 번호
	int endRow = 0;
	
	// 게시판 글 가져오기
	List articleList = null;
	BookDAO dao = BookDAO.getInstance();
	
	if(genre != null){//장르 o때
			count = dao.getGenreArticleCount(genre);
			
			if(range == count){ currentPage -= 1; }//마지막 페이지에 책 한 권만 있는 경우 =>그 책을 지웠을 때, pageNum때문에 생기는 오류 수정하기 위해서 만든 식.
			if(currentPage == 0){ currentPage = 1; }
			
			/* if(range == count) { currentPage -= 1; }
			if(currentPage == 0) { currentPage = 1; } */
			
			// 페이지 시작글 번호
			startRow = (currentPage -1) * pageSize + 1;	
			// 페이지 끝 글 번호
			endRow = currentPage * pageSize;
			
			if(count > 0){
				articleList = dao.getGenreArticle(genre, startRow, endRow);
			}
	}else{//장르 x때
			// 전체 글 개수 가져오기
			count = dao.getArticleCount();
			
			if(range == count) { currentPage -= 1; }
			if(currentPage == 0) { currentPage = 1; }
			
			// 페이지 시작글 번호
			startRow = (currentPage -1) * pageSize + 1;	
			// 페이지 끝 글 번호
			endRow = currentPage * pageSize;
			
			if(count > 0){
				//DB에서 현재 페이지에서 보여줘야할 시작글번호 ~ 끝 글번호까지 가져오기
				articleList = dao.getArticle(startRow, endRow);
			}
	}
	
		//검색용 변수 생성 및 파라미터 받기
		String sel = request.getParameter("sel");
		String search = request.getParameter("search");
			/* 검색 파라미터 받아오는지 확인 */
			//System.out.println("sel" + sel);
			//System.out.println("search"+search);

		//검색된 글수
		if(sel != null&& search!=null){
			count= dao.getSearchArticleCount(sel,search);
			if(count>0){
				articleList = dao.getSearchArticles(sel, search,startRow, endRow);
			}
		}
	
	// 게시판에 글번호 뿌려줄 변수 (DB에 있는 글 고유 번호 X)
	int number = 0;
	// 게시판에 뿌려줄 글 번호 담기
	number = count - (currentPage - 1) * pageSize;	
%>	
<body>
	<p align="center" class="txt">책 목록</p>
	<%if(count == 0) { %>
	<div>
		<table class="table">
			<tr>
				<td align="center">
					<input type = "button" value = "등록" onclick = "window.location.href='mBookListInputForm.jsp'" style="color: white; background-color: black;"/>
					<input type = "button" value = "취소" onclick = "window.location.href='mBookListForm.jsp'" style="color: white; background-color: black;"/>
				</td>
			</tr>
			<tr>
				<td align="center"> 책목록이 없습니다. </td>
			</tr>
		</table>
	</div>
		<%-- 게시글 있을때 --%>
		<%}else{ 
			String id = (String)session.getAttribute("memId");
		%>
	<div>
		<table class="table">
			<tr>
				<td colspan="8" align="right">
					<%if(id != null && id.equals("admin")){ %>
					<input type = "button" value = "책등록" onclick = "window.location.href='mBookListInputForm.jsp'" style="color: white; background-color: black"/>
					<%} %>
				</td>
			</tr>
			<tr>
				<td>No.</td>
				<td>책사진</td>	
				<td>제  목</td>		
				<td>저  자</td>	
				<td>장  르</td>
				<td>발행일</td>
				<td>책가격</td>
				<td>조회수</td>	
			</tr>
			<%for(int i = 0; i < articleList.size(); i++){
				BookDTO article = (BookDTO)articleList.get(i); 
			%>
				<tr>
					<% if(article.getGenre().equals("공포")){ %>
					<td style = "font-size:17px;color:black;"><%=number--%></td>
					<td><img src="/web/mSave/<%= article.getImg()%>" width="80"></td>		
					<td style = "font-size:17px;">
						<a href="mContentForm.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>&startRow=<%=startRow%>&endRow=<%=endRow%>" style="color: black;"><%=article.getName()%></a>
					</td>
					<td style = "font-size:17px;color:black;"><%=article.getWriter()%></td>
					<td style = "font-size:17px;color:red;" ><%=article.getGenre() %></td>
					<td style = "font-size:17px;color:black;" ><%=article.getRegs() %></td>
					<td style = "font-size:17px;color:black;" ><%=article.getPrice() %>원</td>
					<td style = "font-size:17px;" ><%=article.getReadcount()%></td>
					<% } %>
				</tr>
				<tr>
					<% if(article.getGenre().equals("로맨스")){ %>
					<td style = "font-size:17px;color:black;"><%=number--%></td>
					<td><img src="/web/mSave/<%= article.getImg()%>" width="80"></td>		
					<td style = "font-size:17px;">
						<a href="mContentForm.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>&startRow=<%=startRow%>&endRow=<%=endRow%>" style="color: black;"><%=article.getName()%></a>
					</td>
					<td style = "font-size:17px;color:black;"><%=article.getWriter()%></td>
					<td style = "font-size:17px;color:blue;" ><%=article.getGenre() %></td>
					<td style = "font-size:17px;color:black;" ><%=article.getRegs() %></td>
					<td style = "font-size:17px;color:black;" ><%=article.getPrice() %>원</td>
					<td style = "font-size:17px;" ><%=article.getReadcount()%></td>
					<% } %>
				</tr>
				<tr>
					<% if(article.getGenre().equals("판타지")){ %>
					<td style = "font-size:17px;color:black;"><%=number--%></td>
					<td><img src="/web/mSave/<%= article.getImg()%>" width="80"></td>		
					<td style = "font-size:17px;">
						<a href="mContentForm.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>&startRow=<%=startRow%>&endRow=<%=endRow%>" style="color: black;"><%=article.getName()%></a>
					</td>
					<td style = "font-size:17px;color:black;"><%=article.getWriter()%></td>
					<td style = "font-size:17px;color:green;" ><%=article.getGenre() %></td>
					<td style = "font-size:17px;color:black;" ><%=article.getRegs() %></td>
					<td style = "font-size:17px;color:black;" ><%=article.getPrice() %>원</td>
					<td style = "font-size:17px;" ><%=article.getReadcount()%></td>
					<% } %>
				</tr>
				
			<%} %>
			
		</table>
	</div>
		<%} %>
		 <div align = "center" class="bookPage">
	      <%
	         if(count >0){
	            // 10페이지씩 끊어서 목록 보여주게 만들기
	            // 총 몇 페이지 나오는지 계산            0으로 떨어지면 0 아니면 1으로 더한다.
	            //  pageSize로 나눠서 남는 글이 하나라도 있으면 페이지에 1더하기
	            int pageCount = count / pageSize +(count % pageSize ==0?0:1);
	            // 보여줄 페이지 번호의 개수 지정 : 페이지번호도 10개씩 끊어서 보여주겠다.
	            int pageBlock = 10;
	            // 현재 위치한 페이지에서 페이지 뷰어 첫번째 숫자가 무엇인지 찾기
	            int startPage = (int)(currentPage / pageBlock)* pageBlock +1;
	            
	            // 마지막에 보여지는 페이지뷰어에 페이지 개수가 10미만일 경우 마지막 페이지 번호가 endPage가 되도록 설정
	            int endPage = startPage + pageBlock -1;
	            
	            if(endPage > pageCount) endPage = pageCount;
	            
	            // startPage가 10보다 크면 < 보여주기
	            if(startPage > pageBlock){%>
	               <a href = "mBookListForm.jsp?pageNum=<%=startPage-pageBlock%>"> &lt; </a>
	            <%}
	            
	            // 페이지 번호 반복해서 뿌려주기
	            for(int i = startPage; i <= endPage; i++){
	            	if(genre != null){										%>
	               <a href ="mBookListForm.jsp?pageNum=<%=i %>&genre=<%=genre %>" class="nums"> &nbsp; <%=i%> &nbsp; </a>
	              <%  }else{ %>
	               <a href ="mBookListForm.jsp?pageNum=<%=i %>" class="nums"> &nbsp; <%=i%> &nbsp; </a>
	              
	            <%} }
	            
	            // startPage가 10보다 크면 > 보여주기
	            if(endPage < pageCount){%>
	               <a href = "mBookListForm.jsp?pageNum=<%=startPage+pageBlock%>"> &gt; </a>
	            <%}
	         } 
	      %>
	   </div>
<jsp:include page="mFooter.jsp"/>	
</body>
</html>