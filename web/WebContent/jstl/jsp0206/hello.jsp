<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Hello VIEW !!!</h1>
	<%=request.getAttribute("name")%>
	<br/>
	<%=request.getAttribute("num") %>
	<br/>
	<h3><%=session.getAttribute("memId") %></h3>
</body>
</html>