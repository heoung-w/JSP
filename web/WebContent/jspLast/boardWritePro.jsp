<%@page import="web.jspLast.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@page import="java.sql.Timestamp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>write pro</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%  
	
	request.setCharacterEncoding("UTF-8");

	//# 로그인 상태 확인하고 페이지 처리
	if(session.getAttribute("memId") == null) { %>
		<script>
			alert("로그인 후 이용 가능");
			window.location="loginForm.jsp?pageNum=1&from=boardList";
		</script>	
<%	}else{
%>

<jsp:useBean id="article" class="web.jspLast.model.BoardDTO" />
<jsp:setProperty property="*" name="article"/>

<% 
	
	article.setReg(new Timestamp(System.currentTimeMillis()));
	article.setIp(request.getRemoteAddr());
	
	
	BoardDAO dao = BoardDAO.getInstance();
	dao.insertArticle(article);	
	
	response.sendRedirect("boardList.jsp");


	}
%>

<body>

</body>
</html>