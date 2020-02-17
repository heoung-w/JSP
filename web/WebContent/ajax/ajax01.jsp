<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
		java.util.Date day = new java.util.Date();
	%>
	<h1>시간 : <%=sdf.format(day) %></h1>
</body>
</html>