<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Modify</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>

<%
	if(session.getAttribute("memId") == null){
%>		<script>
			alert("로그인 해주세요.");
			window.location="/web/jsp12/loginForm.jsp";
		</script>
<%	}else{%>
<body>
	<br />
	<h1 align="center"> 수정/탈퇴 페이지 </h1>
	<table width="200">
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
<%	}
%>
</html>