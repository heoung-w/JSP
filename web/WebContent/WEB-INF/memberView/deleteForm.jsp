<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 탈퇴</title>
	<link href="/web/memberViewImg/style.css" rel="stylesheet" type="text/css" >
</head>
<c:if test="${check==false}">
	<c:redirect url="/member/loginForm.arim"/>
</c:if>
<c:if test="${check==true }">
<body>
	<br />
	<h2 align="center"> 회원 탈퇴 </h2>
	<form action="/web/member/deletePro.arim" method="post">
		<table> 
			<tr>
				<td colspan="2">
					<input type="password" name="pw" />
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="회원 탈퇴" /> </td>
				<td><input type="button" value="취소" onclick="window.location.href='/web/member/main.arim'" /> </td>
			</tr>
		
		</table>
	</form>

</body>
</c:if>

</html>