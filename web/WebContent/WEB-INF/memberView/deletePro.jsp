<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>deletePro</title>
	<link href="/web/memberViewImg/style.css" rel="stylesheet" type="text/css" >
</head>
<c:if test="${check==true }">
<c:if test="${result ==1 }">
<body>
	<br />
	<table>
		<tr>
			<td>회원 정보가 삭제 되었습니다.</td>
		</tr>
		<tr>
			<td><button onclick="window.location.href='/web/member/main.arim'" > 메인으로 </button> </td>
		</tr>
	</table>
</body>
</c:if>
<c:if test="${result != 1}">
	<script>
		alert("비밀번호가 일치하지 않습니다");
		history.go(-1);
	</script>
</c:if>
</c:if>
<c:if test="${check==false }">
<c:redirect url = "/member/loginForm.arim"/>
</c:if>
</html>




