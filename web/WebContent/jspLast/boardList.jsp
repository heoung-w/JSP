<%@page import="web.jspLast.model.BoardDTO"%>
<%@page import="web.jspLast.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>board</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>

<%
	
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");	
	
	
	String pageNum = request.getParameter("pageNum");	
	if(pageNum == null){	
		pageNum = "1";
	}
	
	// - 현재 페이지에 보여줄 게시글의 시작과 끝 등등 정보 세팅
	int currentPage = Integer.parseInt(pageNum);		
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;		
	int count = 0;					
	int number = 0;				
	
	// - 게시판 글 가져오기
	List articleList = null; 

	BoardDAO dao = BoardDAO.getInstance();

	// # 검색 목록
	String sel = request.getParameter("sel");
	String search = request.getParameter("search");
	if(sel != null && search != null) {
		count = dao.getSearchArticleCount(sel,search);	//  검색된 글 수
		if(count > 0){
			articleList = dao.getSearchArticles(startRow, endRow, sel, search); //  검색된 글 리스트받기
		}
	}else{
		// # 일반 전체 목록 
		count = dao.getArticleCount();		
		if(count > 0) {						
			articleList = dao.getArticles(startRow, endRow);	
		}
	}
	// 게시판에 뿌려줄 글번호 담기
	number = count - (currentPage-1)*pageSize;
%>
<body>
	<br />
	<h1 align="center"> 게시판 </h1>
	
	<%-- 게시글 없을때와 있을때로 구분해서 처리 --%>
	<% if(count == 0) {%>
	<table>
		<tr>
			<td><button onclick="window.location='boardWriteForm.jsp'"> 글쓰기 </button></td>
		</tr>
		<tr>
			<td align="center">게시글이 없습니다.</td>
		</tr>
	</table>
	<%}else{ %>
	<table class="listTable">
		<tr>
		<%if(session.getAttribute("memId") != null){ %>
			<td colspan="6" align="right">
				<button onclick="window.location='myArticles.jsp'"> 내 글보기 </button>
				<button onclick="window.location='boardWriteForm.jsp'"> 글쓰기 </button>
			</td>
		<%}else{%>		
			<td colspan="6" align="right"><button onclick="window.location='boardWriteForm.jsp'"> 글쓰기 </button></td>
		<%} %>
		</tr>
		<tr>
			<td>No.</td>
			<td>제  목</td>
			<td>작성자</td>
			<td>시  간</td>
			<td>조회수</td>
			<td>IP주소</td>
		</tr>
		<%-- 게시글 반복해서 뿌려주기 --%>
		<% for(int i = 0; i < articleList.size(); i++){
			BoardDTO article = (BoardDTO)articleList.get(i);
		%>
		<tr>
			<td><%=number-- %></td>
			<td>
				<%	// 댓글은 제목 들여쓰기
					int wid = 0;
					if(article.getRe_level() > 0) {
						wid = 8*(article.getRe_level());
				%>
				<img src="img/tabImg.PNG" width="<%=wid%>" /> <%-- 배경색으로 들여쓰기 효과 --%>
				<img src="img/replyImg.png" width="11"/>
				<%	}%>
				<a href="contentPwCheck.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage %>&from=boardList"><%=article.getSubject() %></a>
			</td>
			<td><a href="mailto:<%=article.getEmail()%>"><%=article.getWriter() %></a></td>
			<td><%=sdf.format(article.getReg()) %></td>
			<td><%=article.getReadcount() %></td>
			<td><%=article.getIp() %></td>
		</tr>
		<%}%>
	</table>
	<%} %>
	<%-- 목록의 페이지번호 뷰어 설정 --%>
	<div align="center">
		<br />
	<%
		if(count > 0){
			
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			int pageBlock = 10;			
			int startPage = (int)(currentPage/pageBlock)*pageBlock + 1;
			int endPage = startPage + pageBlock - 1;
			if(endPage > pageCount) endPage = pageCount;

			if(startPage > pageBlock){ %>
				<a href="boardList.jsp?pageNum=<%= startPage-pageBlock %>" > &lt; </a>
			<%}
			for(int i = startPage; i <= endPage; i++){ %>
				<a href="boardList.jsp?pageNum=<%=i %>" name="list"> &nbsp; <%=i %> &nbsp; </a>
			<%}
			if(endPage < pageCount){ %>
				<a href="boardList.jsp?pageNum=<%= startPage+pageBlock %>" > &gt; </a>
			<%}
		}
	%>
		<br /><br />
		<%-- # 작성/내용 검색   --%>
		<form action="boardList.jsp" >
			<select name="sel">
				<option value="writer">작성자</option>
				<option value="content">내용</option>
			</select>
			<input type="text" name="search" />
			<input type="submit" value="검색" />
		</form>
		
		<%-- # 메인으로 가는 버튼 추가 --%>
		<br />
		<button onclick="window.location='main.jsp'"> 메인으로 </button>
	</div>
	
</body>
</html>