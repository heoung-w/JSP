<%@page import="web.project.model.MemberDAO"%>
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
	String id = (String)session.getAttribute("memId");//Member테이블에 있는 회원 id써야 하니까 id를 받고
	String num = request.getParameter("num");//책 고유 넘버를 책 content페이지에서 넘겨주니까 bk_num도 받고
	String pageNum = request.getParameter("pageNum");//책 고유 넘버를 책 content페이지에서 넘겨주니까 bk_num도 받고
	
	MemberDAO dao = new MemberDAO();//MemberDAO에 장바구니에 책 고유 넘버 넣어주는 메서드가 있으니까 MemberDAO()호출. 
	dao.addBook(id, num);
%>
<script>
	alert("장바구니에 담겼습니다.");
	window.location.href="mContentForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
</script>
<body>

</body>
</html>