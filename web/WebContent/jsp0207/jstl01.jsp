<%@page import="web.jsp0207.mvc.TestVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%-- #1. 변수 선언 --%>
	<%-- 방법 1. value : 값 --%><c:set var="id" value ="java"/>
	<%-- 방법 2. 태그 중간에 값 작성--%><c:set var="pw">1234</c:set>
	<%-- 
		<h2>id:${id }</h2>  
		<h2>pw:${pw }</h2>
	--%>
	<%-- 프로퍼티 값 설정 --%>
	<%-- <% TestVO vo = new TestVO(); %>
		<jsp:setProperty property="vo" name="id" value="test"/> 똑같은 말임
		<c:set target="<%= vo %>" property="id" value ="test"/>
		<h2>vo.id = <%= vo.getId()%></h2>--%>
	<%-- 
		<jsp:useBean id="vo" class="web.jsp0207.mvc.TestVO"/>
		<c:set target="${vo}" property="id" value="test"/>
		<h2>vo.id = ${vo.getId()}</h2>
	--%>	
	
	<%-- #2. 변수 삭제 --%>
	<%-- 
		<c:remove var="id"/>
		<c:remove var="pw"/>
		<h2>id = ${id}</h2>
		<h2>pw = ${pw}</h2>
	--%>	
		
	<%-- 
		#3. if
		test : 조건식 El로 작성
		c:if 태그 사이에 조건식이 참일경우 실행(출력)할 내용 작성
	--%>
	<c:set var="num" value="100"/>
	<c:if test="${num >= 100}">
		<h2>${num}은 100보다 크거나 같다.</h2>
	</c:if>
	<c:if test="${num > 100 }">
		<h2>${num }은 100보다 작다</h2>
	</c:if>
	
	<%-- #4. choose - when - otherwise 
		<c:choose>
			<c:when test="${num>100}">
				<h2>100 보다 크다</h2>
			</c:when>
			<c:when test="${num<100 }">
				<h2>100보다 작다</h2>
				</c:when>
			<c:otherwise>
				<h2>100과 같다</h2>
			</c:otherwise>
		</c:choose>
	--%>
	
	<%-- #5. forEach --%>
	<%-- var : 반복하여 데이터를 담아줄 변수 선언,  items : 반복시킬 배열변수 지정 --%>
	<%-- 업그레이드 for문 같은 거임. --%>

		<c:set var="arr" value="<%=new int[]{1,2,3,4,5} %>"/>

	<%-- 
		<c:forEach var="i" items="${arr }">
			<h2>${i}</h2>
		</c:forEach>
	--%>
	<%-- 일반 for문 --%>
	<%-- var = 변수(i) , begin =시작 , end = 끝, step = 몇씩 증가할건지 --%>
	<%-- 
		<c:forEach var="i" begin="1" end="10" step="1">
			<h2>${i }</h2>
		</c:forEach>
	--%>
	
	<%-- 구구단 
		<c:forEach var="i" begin ="2" end="9" step="1">
			<h1> **** ${i}단 *****</h1>
			<c:forEach var="j" begin ="1" end="9" step="1">
				<h2>${i} * ${j} = ${i*j}</h2>
			</c:forEach>
		</c:forEach>
	--%>
	
	
	<%-- status.index : 0부터 시작하는 루프의 인덱스
		 status.count : 현재 몇번째 루프인지의 값. 1부터 시작
		 status.current : var속성값.
		 status.first : 현재 첫번째 루프이면 참입니다.
		 status.last : 현재 마지막 루프이면 참입니다.
	 --%>
	<c:forEach var="i" items="${arr }" varStatus="status">
		<h2>${status.count} : ${status.index } : ${status.current} : ${status.first} ${status.last}</h2>
	</c:forEach>
	
	
	<%-- delims = , 기준으로 나눠준다 (split 같은느낌) --%>
	<c:forTokens var = "a" items="a,b,c,d,e,f,g" delims=",">
		<h2>${a }</h2>
	</c:forTokens>
	
	
	<%-- c:import : include와 비슷 --%>
	<c:import var="test" url ="test.jsp"/>
	<h2>${test}</h2>
	
	<%-- redirect = response.sendRedirect()와 동일한 기능(보내기) --%>
	<%-- <c:redirect url="test.jsp"/> --%>
	
	<%-- url ....../web/js0207.../test.jsp?id=java&pw=1234... --%>
	<%-- 
		<c:url var="u" value="test.jsp">
			<c:param name="id" value="java"/>
			<c:param name="pw" value="1234"/>
		</c:url>
		<c:redirect url="${u}"/>
	--%>
	
	
	
	
	
	
	
	
	
	

</body>
</html>