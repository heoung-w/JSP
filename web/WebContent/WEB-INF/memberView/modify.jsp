<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원정보 수정/탈퇴</title>
	<link href="/web/memberViewImg/style.css" rel="stylesheet" type="text/css" >
</head>
<c:if test="${check == false }">
	<script>
		alert("로그인후 이용해주세요!");
	</script>
</c:if>
<c:if test="${check == true }">
<body>
	<br />
	<h2 align="center"> 수정 / 탈퇴 페이지 </h2>
	<table>
		<tr>
			<td><a href="/web/member/modifyForm.arim">정보수정</a></td>
		</tr>
		<tr>
			<td><a href="/web/member/deleteForm.arim">회원탈퇴</a></td>
		</tr>
		<tr>
			<td><a href="/web/member/main.arim">메인으로</a></td>
		</tr>
	
	</table>

</body>
</c:if>
</html>