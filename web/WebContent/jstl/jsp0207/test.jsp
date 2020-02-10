<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	request.setAttribute("name", "피카츄");
%>


<body>
	요청 URI : ${pageContext.request.requestURI} <br/>
	request의 속성 : ${requestScope.name }	<br/>	
	속성명만 작성해서 데이터 꺼내오기 : ${name }<br/> <!-- request와 session 안에 name값이 통틀어서 하나일경우는 name만 써도 결과값이 출력된다 -->
	파라미터 : ${param.test }	<br/>
	존재 하지 않을 경우 :  ${memId}	<br/>
	
	
	
</body>
</html>