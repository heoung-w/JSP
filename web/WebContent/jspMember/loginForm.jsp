<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
	<link href="style.css" rel="stylesheet" type="text/css" >
</head>
<%
	// 로그인 상태이면 main 페이지로 바로 돌아가게 처리
	if(session.getAttribute("memId") != null){  %>
		<script>
			alert("이미 로그인 된 상태입니다!!")
			window.location.href="main.jsp";
		</script>	
<%	}else{		// memId라는 세션이 없을 경우 ==> 로그인 안된 상태
%>
<body>
	<br />
	<h2 align="center" > 로그인 </h2>
	<form action="loginPro.jsp" method="post">
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="id" /></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="pw" /></td>
			</tr>
			<tr>
				<td colspan="2">
				<input type="checkbox" name="auto" value="1" /> 자동로그인 
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="로그인" />
					<input type="button" value="회원가입" onclick="window.location.href='signupForm.jsp'" />
				</td>
			</tr>
		</table>
	</form>
</body>
<%} %>
</html>