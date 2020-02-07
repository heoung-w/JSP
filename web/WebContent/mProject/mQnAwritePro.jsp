<%@page import="web.project.model.QnADAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 작성 Pro 페이지</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	request.setCharacterEncoding("utf-8");
	// 글 작성 form 페이지에서 넘어오는 데이터 받아서 
	// form에서 넘어오는 데이터 : 작성자, 제목, 이메일, 내용, 비밀번호, num, ref, re_step, re_level
	String id = (String)session.getAttribute("memId");
	String admin = (String)session.getAttribute("admin");
	if(id.equals("admin")){
%>

<jsp:useBean id="article" class="web.project.model.QnADTO"/>
<jsp:setProperty property="*" name="article"/>

<%
	// form에서 넘어오는 데이터를 제외한 나머지 채워줄 부분 채우기
	// 시스템클래스에 있는 현재 시간을 가져와 Timestamp 객체로 저장하기
	article.setReg(new Timestamp(System.currentTimeMillis()));
	// DB 저장
	QnADAO dao = QnADAO.getInstance();
	dao.insertArticle(article);
	response.sendRedirect("mQnAForm.jsp");
%>

<%}else{ %>
	<script>
			alert("관리자만 이용 가능합니다.");
			window.location="mQnAForm.jsp";
	</script>
	<% }%>
</html>