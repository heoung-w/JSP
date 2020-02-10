<%@page import="web.jsp0207.mvc.TestVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2> 기존 : <%=request.getAttribute("num") %></h2>
	<h2> 기존 : <%=request.getAttribute("id") %></h2>
	<h2> EL : ${requestScope.num }</h2>
	<h2> EL : ${requestScope.id }</h2>

	<h2>기존 : <%=request.getAttribute("data") %></h2>
	<h2>EL : ${data}</h2>
	
	<h2>기존 : age = </h2>
	<h2>EL : ${age+10}</h2>
	<h2>EL : ${age=="10"}</h2>
	
	<h2>session num값 : ${sessionScope.num}</h2>
	<h2>num : ${num }</h2> <!-- request 키 값도 num이고 session도 키값이 num일때 request에 저장된 값을 출력함 -->
	
	<h2>int 배열 arr : <%=request.getAttribute("arr") %></h2>
	<h2>int 배열 arr : ${arr[1]}</h2>
	
	<h2>list = ${list}</h2>
	<h2>list = ${list[0]}</h2>
	<h2>list = ${list.get(1)}</h2>
	
	<h2>vo = ${vo.Id}</h2>
	<h2>vo = ${vo.Name}</h2>
	<h2>vo = ${vo.age()}</h2>

</body>
</html>