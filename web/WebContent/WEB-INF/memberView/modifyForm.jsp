<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 정보 수정</title>
	<link href="/web/memberViewImg/style.css" rel="stylesheet" type="text/css" >
</head>
<c:if test="${check==false }">
	<c:redirect url = "/member/login.arim"/>
</c:if>
<c:if test="${check ==true }">
<body>
	<br />
	<h1 align="center">회원 정보 수정</h1>
	<form action="/web/member/modifyPro.arim" method="post" enctype="multipart/form-data">
	<table>
		<tr>
			<td>아이디 * </td>
			<td>${member.id }</td>
		</tr>
		<tr>
			<td>비밀번호 * </td>
			<td><input type="password" name="pw" value="${member.pw}"/></td>
		</tr>
		<tr>
			<td>비밀번호 확인 * </td>
			<td><input type="password" name="pwCh" /></td>
		</tr>
		<tr>
			<td>이름 * </td>
			<td>${member.name}</td>
		</tr>
		<tr>
			<td>생년월일</td>
			<td>
			<c:if test="${member.birth ==null }">
				<input type="text" name="birth" maxlength="8" />
			</c:if>
			<c:if test="${ member.birth !=null}">
				<input type="text" name="birth" maxlength="8" value="${member.birth}"/>
			</c:if>
			</td>
		</tr>
		<tr>
			<td>Email </td>
			<td>
			<c:if test="${member.email ==null }">
				<input type="text" name="email" />
			</c:if>
			<c:if test="${member.email != null }">
				<input type="text" name="email" value="${member.email }"/>
			</c:if>
			</td>
		</tr>
		<tr>
			<td>Photo </td>
			<td>
				<c:if test="${member.photo ==null }">
					<img src="/web/ViewImg/img/default.png" width="100" /> <br />
				</c:if>
				<c:if test="${member.email !=null }">
					<img src="/web/save/${member.photo } width="100" /> <br />
				</c:if>
				<input type="file" name="photo" />
				<input type="hidden" name="exPhoto" value="${member.photo }"/>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="수정" />
				<input type="button" value="취소" onclick="window.location.href='/web/member/main.arim'" /> 
			</td>
		</tr>
	</table>
	</form>
</body>
</c:if>
</html>