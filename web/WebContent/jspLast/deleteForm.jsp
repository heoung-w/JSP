<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Delete Form</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	//로그인상태가 아니면 로그인 페이지로 이동
	if(session.getAttribute("memId") == null){ 	
%>		<script>
			alert("로그인 해주세요.");
			window.location="/web/jsp12/loginForm.jsp";
		</script>
		
<%	//로그인상태이면
	}else{
%>	
<body>
	<br />
	<h1 align="center"> 회원 탈퇴 </h1>
	<form action="deletePro.jsp" method="post" name="inputForm">
		<table>
			<tr>
				<td colspan="2"><input type="password" name="pw" /></td>
			</tr>
			<tr>
				<td><input type="submit" value="회원 탈퇴" /></td>
				<td><input type="button" value="취소" onclick="window.location='main.jsp'"/></td>
			</tr>
		</table>
	</form>
</body>
<%} %>
</html>