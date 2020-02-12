<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>signup pro</title>
</head>
<c:if test="${check == true}">
	<script>
		alert("해당 경로를 접근 불가능합니다.....")
	</script>
</c:if>
<c:redirect url = "/member/main.arim"/>
<body>

</body>
</html>