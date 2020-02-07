<%@page import="web.project.model.MemberDAO"%>
<%@page import="web.project.model.BookDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mMyshopDeletePro</title>
<link href = "style.css" rel = "stylesheet" type = "text/css"/>
</head>
<%
	if(session.getAttribute("memId") == null){ %>
		<script>
			alert("로그인후 이용해주세요!!");
			window.location.href="mLoginForm.jsp";
		</script>
	<%}else{ 

		request.setCharacterEncoding("UTF-8");
		String id = (String)session.getAttribute("memId");
		String [] bookChecks=request.getParameterValues("bookCheck");//체크박스에 담긴 책 고유번호들을 배열로 받기.
		
		if(bookChecks != null){
		
		//id를 받아서 MemberDAO를 호출하고 MemberDAO에서 장바구니 삭제 메서드를 만들어서
		MemberDAO dao=new MemberDAO();
		
		for(int i=0;i<bookChecks.length;i++){
			String book=bookChecks[i];
			dao.deleteCart(book);
			dao.deleteMemberCart(book);
		}
		response.sendRedirect("mMyshopForm.jsp");
		%>
<body>
</body>
		<%}else{%>
		<script>
	      alert("삭제하실 목록을 선택해 주세요!!");
	      history.go(-1);
	    </script>
	<%} %>
<% } %>
</html>