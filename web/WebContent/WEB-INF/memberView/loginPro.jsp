<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>loginPro</title>
</head>
<c:if test="${check == false }">
	<c:redirect url ="/member/loginForm.arim"/>
</c:if>
<c:if test="${check == true }">
	<c:redirect url ="/member/main.arim"/>
</c:if>
<body>

</body>
</html>