<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>logout</title>
</head>
<c:if test = "${sessionScope.memId == null}">
	<c:redirect url = "/member/main.arim"/>
</c:if>
<c:if test= "${sessionScope.memId != null }">
	<script>
		alert("로그아웃 실패!!");
		history.go(-1);
	</script>
</c:if>
<body>

</body>
</html>