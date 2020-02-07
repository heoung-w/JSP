<%@page import="web.project.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mMemberDeleteByAdmin</title>
<link href = "style.css" rel = "stylesheet" type = "text/css"/>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("memId");
	
	if(id.equals("admin")){
		
		String [] memberChecks=request.getParameterValues("memberCheck");//체크박스에 담긴 아이디들을 배열로 받기
		if(memberChecks !=null){
			
			MemberDAO dao=new MemberDAO();
			
			for(int i=0;i<memberChecks.length;i++){
				String member=memberChecks[i];
				dao.deleteMemberByAdmin(member);	
			}
			response.sendRedirect("mMemberList.jsp");
%>
<body>
</body>
	<%}else{%>
		<script>
			alert("탈퇴시킬 회원을 선택하세요");
			history.go(-1);
		</script>
	<%} %>
<%}else{ %>
		<script>
				alert("관리자만 이용 가능합니다.");
				window.location="mBookListForm.jsp";
		</script>
<% } %>
</html>