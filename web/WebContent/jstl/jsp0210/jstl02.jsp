<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL</title>
</head>
<body>

	<%//  request.setCharacterEncoding("UTF-8"); 와 동일 %>
	<fmt:requestEncoding value="UTF-8"/>

	<%-- 컨트롤러에서 request를 통해 보내준 Date 객체 반이 출력 --%>	
	<fmt:formatDate value="${day }" type="date"/><br/>
	<fmt:formatDate value="${day }" type="time"/><br/>
	<fmt:formatDate value="${day }" type="both"/><br/>
	<br/>
	
	<fmt:formatDate value="${day }" type="both" dateStyle="short"/><br/>
	<fmt:formatDate value="${day }" type="both" dateStyle="medium"/><br/>
	<fmt:formatDate value="${day }" type="both" dateStyle="Long"/><br/>
	<fmt:formatDate value="${day }" type="both" dateStyle="full"/><br/>
	<br/>
	
	<fmt:formatDate value="${day }" type="both" timeStyle="short"/><br/>
	<fmt:formatDate value="${day }" type="both" timeStyle="medium"/><br/>
	<fmt:formatDate value="${day }" type="both" timeStyle="Long"/><br/>
	<fmt:formatDate value="${day }" type="both" dateStyle="full" timeStyle="full"/><br/>
	<br/>
	
	<fmt:formatDate value="${day }" pattern="yyyy년 MM월 dd일"/> <br/>

	<%-- 숫자관련 --%>
	<fmt:formatNumber value="1000000" groupingUsed="true"/><br/>
	<fmt:formatNumber value="1000000" groupingUsed="false"/><br/>
	<fmt:formatNumber value="1000000" type="number"/><br/>
	
	<fmt:formatNumber value="100.25" type="currency" currencySymbol="\\"/><br/>
	<fmt:formatNumber value="100.2" type="currency" currencySymbol="$"/><br/>
	
	<fmt:formatNumber value="100.25" type="percent"/><br/>
	<fmt:formatNumber value="100.1234" pattern=".00"/><br/>
	<br/>
	
	<%-- 나라별 시간  --%>
	<fmt:timeZone value="GMT">
		GMT 영국 : <fmt:formatDate value="${day }" type="both"/>
	</fmt:timeZone>
	<br/>
	<fmt:timeZone value="GMT-8">
		GMT-8 뉴욕 : <fmt:formatDate value="${day }" type="both"/>
	</fmt:timeZone>
	<br/><br/>
	
	<%-- 문자열을 숫자로 변환해주는 기능 integerOnly는 소수점을 빼고 나타내기 --%>
	<fmt:parseNumber value="10000.2222" var="result" integerOnly="true"/>
	result : ${result }
	
</body>
	
</html>