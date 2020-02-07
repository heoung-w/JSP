<%@page import="web.project.model.QnADTO"%>
<%@page import="web.project.model.QnADAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시판</title>
	<link href="style3.css" rel="stylesheet" type="text/css">

</head>
	<jsp:include page="mHeader.jsp"/>
<% if(session.getAttribute("memId")==null){%>
	<script>
		alert("로그인 후 이용 가능");
		window.location.href="mLoginForm.jsp";
	</script>
<%}
	String id = "";
	if(session.getAttribute("memId") != null){
		id = (String)session.getAttribute("memId");
	}	

	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	//String pageNum = request.getParameter("pageNum");
	
	String pageNum = request.getParameter("pageNum");	
	if(pageNum == null){	
		pageNum = "1";
	}
	
	int currPage = Integer.parseInt(pageNum);
	int startRow = (currPage - 1) * pageSize + 1;
	int endRow = currPage * pageSize;
	int count = 0;
	int number = 0;
	
	List articleList = null;
	QnADAO dao = QnADAO.getInstance();
	
	count = dao.getArticleCount();
	
	if(count > 0) articleList = dao.getArticles(startRow, endRow);
	
	number = count - (currPage - 1) * pageSize;
%>
<body>
		<p align="center" class="txt"> QnA 게시판</p>
	<%if(count == 0){ %>
		<table class="table" style="width: 80%;">
			<tr>
				<td><button onclick="window.location='mQnAwrite.jsp'" style="color: white; background-color: black;">글쓰기</button></td>
			</tr>
			<tr>
				<td align="center">게시글이 없습니다.</td>
			</tr>
		</table>
	<%}else{ %>
		<table class="table" style="width: 80%;">
			<tr>
					<%if(id!= null&&id.equals("admin")) {%>
					<td>   </td><td>   </td><td>   </td><td>   </td>
						<td>
							<button onclick="window.location='mQnAwrite.jsp'" style="color: white; background-color: black;">글쓰기</button>
						</td>
					<%} %>
			</tr>
			<tr>
				<td>No.</td>
				<td>작성자</td>
				<td>제   목</td>
				<td>작성일</td>
				<td>조회수</td>
			</tr>
		<%
				for(int i = 0; i < articleList.size(); i++){
					QnADTO article = (QnADTO)articleList.get(i); 
		%>	
			<tr>
				<td><%=number-- %></td>
				<td><a href="mailto:<%=article.getEmail() %>" style="color: black;"><%=article.getWriter() %></a></td>
				<td>
					<a href="mQnAcontent.jsp?num=<%=article.getNum()%>&pageNum=<%=currPage%>" style="color: black;"><%=article.getTitle() %></a>
				</td>
				<td><%=sdf.format(article.getReg()) %></td>
				<td><%=article.getRead_count() %></td>
			</tr>
		<%} %>	

	</table>
	<%} %>
	<%-- 게시판 목록의 페이지 뷰어 설정 --%>
	<div align="center" class="bookPage">
		<%
			if(count > 0){
				// 10페이지 씩 끊어서 목록 보여주게 만들기
				// 총 몇 페이지 나오는지 계산해서 페이지사이즈로 나누고 남은 값이 하나라도 있으면 1페이지 더하기
				int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
				// 보여줄 페이지 번호의 개수 지정 : 페이지번호로 10개씩 끊어서 보여주겠다.
				int pageBlock = 10;
				// 현재 위치한 페이지에서 페이지 뷰어 첫번째 숫자가 무엇인지 찾기
				int startPage = (int)(currPage / pageBlock)*pageBlock + 1;
				// 마지막에 보여지는 페이지 뷰어의 페이지 개수가 10 미만일 경우 마지막 페이지 번호가 endpage가 되도록 하라
				int endPage = startPage + pageBlock - 1;
				if(endPage > pageCount) endPage = pageCount;
				
				// startPag가 10보다 크면 -> 표시 보여주기
				if(startPage > pageBlock){%>
					<a href="mQnAForm.jsp?pageNum=<%=startPage-pageBlock%>">&lt;</a>
				<%}
				
				for(int i = startPage; i <= endPage; i++){%>
					<a href="mQnAForm.jsp?pageNum=<%=i %>" class="nums"> &nbsp; <%=i %> &nbsp; </a>
				<%}
				
				if(endPage > pageCount){%>
					<a href="mQnAForm.jsp?pageNum=<%=startPage-pageBlock%>">&gt;</a>
				<% }
					
			}
		%>
	</div>
</body>
<jsp:include page="mFooter.jsp"/>	
</html>