<%@page import="web.project.model.MemberDAO"%>
<%@page import="web.project.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>signupPro</title>
</head>
<%
		request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="member" class = "web.project.model.MemberDTO"/>
<jsp:setProperty property="*" name="member"/>
<%
		// 회원가입 시키기 : DAO 객체 생성
		MemberDAO dao = new MemberDAO();
		// 회원가입 메서드 호출 
		dao.insertMember(member);
		
		// 가입후 main 페이지로 이동시키기
		response.sendRedirect("mMain.jsp");		
%>
<body>
</body>
</html>