<%@page import="web.project.model.QnADAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deletePro page</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%request.setCharacterEncoding("utf-8"); %>

	<jsp:useBean id="article" class="web.project.model.QnADTO"/>
<%
	int num = 0;
	if(request.getParameter("num") != null){
		num = Integer.parseInt(request.getParameter("num"));
	}
	article.setNum(num);

	QnADAO dao = QnADAO.getInstance();
	dao.deleteArticle(article);
	
	String id = (String)session.getAttribute("memId");
	String admin = (String)session.getAttribute("admin");
	
	response.sendRedirect("mQnAForm.jsp");
	
	if(id.equals("admin")){
	
 %>
<body>
	
</body>
	<%}else{ %>
		<script>
				alert("관리자만 이용 가능합니다.");
				window.location="mQnAForm.jsp";
		</script>
	<%} %>
</html>