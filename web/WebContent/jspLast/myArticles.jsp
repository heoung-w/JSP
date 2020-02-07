<%@page import="web.jspLast.model.BoardDTO"%>
<%@page import="web.jspLast.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	// # 로그인 체크 
	if(session.getAttribute("memId") == null) { %>
		<script>
			alert("로그인 후 이용 가능");
			window.location="loginForm.jsp?pageNum=1&from=myArticles";
		</script>	
<%	}else{// # 세션X 쿠키 있는건 알아서 처리하기.

	String id = (String)session.getAttribute("memId");

	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");	
	
	
	String pageNum = request.getParameter("pageNum");	
	if(pageNum == null){	
		pageNum = "1";
	}
	
	
	int currentPage = Integer.parseInt(pageNum);		
	int startRow = (currentPage - 1) * pageSize + 1;	
	int endRow = currentPage * pageSize;			
	int count = 0;					
	int number = 0;									
	
	
	List articleList = null; 

	BoardDAO dao = BoardDAO.getInstance();
	count = dao.getMyArticleCount(id);		
	
	if(count > 0) {						
		
		articleList = dao.getMyArticles(startRow, endRow, id);	
	}
	
	number = count - (currentPage-1)*pageSize;
%>
<body>
	<br />
	<h1 align="center"> 나의 글 게시판 </h1>
	
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
	<table>
		<tr>
			<td colspan="6" align="right"><button onclick="window.location='boardWriteForm.jsp'"> 글쓰기 </button></td>
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
				<%	
					int wid = 0;
					if(article.getRe_level() > 0) {
						wid = 8*(article.getRe_level());
				%>
				<img src="img/tabImg.PNG" width="<%=wid%>" /> 
				<img src="img/replyImg.png" width="11"/>
				<%	}%>
				<a href="boardContent.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage %>&from=myArticles"><%=article.getSubject() %></a>
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
	<%
		if(count > 0){
			
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			int pageBlock = 10;			
			int startPage = (int)(currentPage/pageBlock)*pageBlock + 1;
			int endPage = startPage + pageBlock - 1;
			if(endPage > pageCount) endPage = pageCount;
			
			if(startPage > pageBlock){ %>
				<a href="myArticles.jsp?pageNum=<%= startPage-pageBlock %>" > &lt; </a>
			<%}
			for(int i = startPage; i <= endPage; i++){ %>
				<a href="myArticles.jsp?pageNum=<%=i %>" name="list"> &nbsp; <%=i %> &nbsp; </a>
			<%}
			if(endPage < pageCount){ %>
				<a href="myArticles.jsp?pageNum=<%= startPage+pageBlock %>" > &rt; </a>
			<%}
		}
	} 
	%>
	
	<br /><br />
	<button onclick="window.location='boardList.jsp'"> 전체 게시판 </button>
	<button onclick="window.location='main.jsp'"> 메인으로 </button>
	</div>
	
</body>
</html>