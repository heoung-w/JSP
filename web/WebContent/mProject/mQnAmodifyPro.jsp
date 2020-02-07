<%@page import="web.project.model.QnADAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	request.setCharacterEncoding("UTF-8");
	
	String id = (String)session.getAttribute("memId");
	String admin = (String)session.getAttribute("admin");
	
	if(id.equals("admin")){
%>

 <jsp:useBean id="article" class="web.project.model.QnADTO" />

<%
	int num = 0;
	if(request.getParameter("num") != null){
		num = Integer.parseInt(request.getParameter("num"));
	}
	article.setNum(num); 
	article.setWriter(request.getParameter("writer"));
	article.setTitle(request.getParameter("title"));
	article.setEmail(request.getParameter("email"));
	article.setContent(request.getParameter("content"));
		
	QnADAO dao = QnADAO.getInstance();
	dao.updateArticle(article);
	
	response.sendRedirect("mQnAForm.jsp");
%>
<body>
	<br />
		<table>
			<tr>
				<td> <b>글이 업데이트되었습니다.</b> <br /></td>
			</tr>
			<tr>
				<td>
					<button onclick="window.location='mQnAForm.jsp'"> 리스트로  </button> <br />
				</td>
			</tr>
		</table>
</body>
<% }else{%>
		<script>
				alert("관리자만 이용 가능합니다.");
				window.location="mQnAForm.jsp";
		</script>
<%} %>
</html>