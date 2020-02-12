<%@page import="web.jspBoard.model.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	request.setCharacterEncoding("UTF-8");	
	// 글작성 form페이지에서 넘어오는 데이터 받아서
	// form에서 넘어오는 데이터 : 
	//	작성자, 제목, email, 내용, 비밀번호, num, ref, re_step, re_level
%>

<jsp:useBean id="article" class="web.jspBoard.model.BoardDTO"/>
<jsp:setProperty property="*" name="article"/>

<%
	// form에서 넘어오는 데이터를 제외한 나머지 체워줄 부분 체우기
	// 시스템클래스에 있는 현재 시간을 가져와 Timestamp 객체로 저장하기.
	article.setReg(new Timestamp(System.currentTimeMillis()));
	article.setIp(request.getRemoteAddr());
	// DB 저장
	BoardDAO dao = new BoardDAO();
	dao.insertArticle(article);
	
	response.sendRedirect("list.jsp");
	
%>


<body>
	
</body>
</html>