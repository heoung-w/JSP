<%@page import="web.jspLast.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>modify pro</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<% 
	request.setCharacterEncoding("UTF-8");  // submit - post방식 인코딩 처리
	
	//# 로그인 상태 확인하고 페이지 처리
	if(session.getAttribute("memId") == null) { %>
		<script>
			alert("로그인 후 이용 가능");
			window.location="loginForm.jsp?pageNum=1&from=boardList";
		</script>	
<%	}else{// # 세션X 쿠키 있는건 알아서 처리하기. (main꺼 복사해오던지...)
%>

<jsp:useBean id="article" class="web.jspLast.model.BoardDTO" />
<jsp:setProperty property="*" name="article"/>

<%
	
	String pageNum = request.getParameter("pageNum");

	BoardDAO dao = BoardDAO.getInstance();
	int check = dao.updateArticle(article);
	
	if(check == 1){
		String uri = "boardList.jsp?pageNum=" + pageNum;
		response.sendRedirect(uri);
	}else{%>
		<script type="text/javascript">
			alert("비밀번호가 맞지 않습니다.");
			history.go(-1);
		</script>
	<%}
%>

<%} %>
<body>

</body>
</html>