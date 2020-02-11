<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원정보 수정/탈퇴</title>
	<link href="style.css" rel="stylesheet" type="text/css" >
</head>
<%
	// 로그인된 상태만 접근 가능하게..
	// 로그인 안된상태로 접근하면 loginForm으로 이동하게
	if(session.getAttribute("memId") == null) {  %>
		<script>
			alert("로그인을 해주세요!!");
			window.location.href="loginForm.jsp";
		</script>
<% 	}else{
%>
<body>
	<br />
	<h2 align="center"> 수정 / 탈퇴 페이지 </h2>
	<table>
		<tr>
			<td><a href="modifyForm.jsp">정보수정</a></td>
		</tr>
		<tr>
			<td><a href="deleteForm.jsp">회원탈퇴</a></td>
		</tr>
		<tr>
			<td><a href="main.jsp">메인으로</a></td>
		</tr>
	
	</table>

</body>
<%	} %>
</html>