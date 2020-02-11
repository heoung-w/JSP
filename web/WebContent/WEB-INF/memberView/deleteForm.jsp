<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 탈퇴</title>
	<link href="style.css" rel="stylesheet" type="text/css" >
</head>
<%
	if(session.getAttribute("memId") == null) { %>
		<script>
			alert("로그인 해주세요!!");
			window.location.href="loginForm.jsp";
		</script>
<%	}else{
%>
<body>
	<br />
	<h2 align="center"> 회원 탈퇴 </h2>
	<form action="deletePro.jsp" method="post">
		<table> 
			<tr>
				<td colspan="2">
					<input type="password" name="pw" />
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="회원 탈퇴" /> </td>
				<td><input type="button" value="취소" onclick="window.location.href='main.jsp'" /> </td>
			</tr>
		
		</table>
	</form>

</body>
<%	} %>

</html>