<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Main</title>
	<link href="/web/memberViewImg/style.css" rel="stylesheet" type="text/css" >

</head>

<c:if test = "${sessionScope.memId == null}">
<body>
	<br />
	<h1 align="center"> 메인페이지 </h1>
	<table>
		<tr>
			<td> 로그인 원하시면 버튼을 누르세요 <br />
				<button onclick="window.location.href='/web/member/loginForm.arim'" >로그인</button>
			</td>
		</tr>
		<tr>
			<td>
				<a href="/web/member/signupForm.arim" > 회원가입 </a>
			</td>
		</tr>
	</table>
	<br /><br /><br /><br />
	<div align="center">
		<img src="img/beach.jpg" width="700" />
	</div>
</body>
</c:if>
<c:if test="${sessionScope.memId != null}">
<body>
	<br />
	<h1 align="center"> 메인페이지 </h1>
	<table>
		<tr>
			<td>${sessionScope.memId}님 환영합니다.<br />
				<button onclick="window.location.href='/web/member/logout.arim'" >로그아웃</button>
				<button onclick="window.location.href='/web/member/modify.arim'" >회원정보 변경</button>
			</td>
		</tr>
	</table>
	<br /><br /><br /><br />
	<div align="center">
		<img src="/memberViewImg/img/beach.jpg" width="700" />
	</div>
</body>
</c:if>
</html>