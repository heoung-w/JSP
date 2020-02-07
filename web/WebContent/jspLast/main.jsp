<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Main</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
		
<%
	// 세션이 없다면,
	if(session.getAttribute("memId") == null){
		// 세션이 없을때 쿠키는 있는지 2중체크
		String id = null, pw = null, auto = null;
		Cookie [] cs = request.getCookies();
		if(cs != null){		// 쿠키가 있다면 데이터 꺼내와 담기
			for(Cookie coo : cs){
				if(coo.getName().equals("autoId")) id = coo.getValue();
				if(coo.getName().equals("autoPw")) pw = coo.getValue();
				if(coo.getName().equals("autoCh")) auto = coo.getValue();
			}
		} 
		if(auto != null && id != null && pw != null){
			response.sendRedirect("loginPro.jsp");
		}
		%>
<body>
	<br />
	<h1 align="center"> 메인 페이지 </h1>
	<table>
		<tr>
			
			<td rowspan="2">
				<a href="boardList.jsp" >게시판</a>
			</td>
			<td> 로그인 원하시면 버튼을 누르세요 <br />
				<button onclick="window.location='loginForm.jsp'"> 로그인 </button> <br />
			</td>
		</tr>
		<tr>
			<td>
				<a href="signupForm.jsp" >회원가입</a>
			</td>
		</tr>
	</table>
	<br /><br /><br /><br />
	<div align="center">
		<img src="img/beach.jpg" width="800" />
	</div>
</body>
<%	}else{ 
		
		String id = (String)session.getAttribute("memId");
%>
<body>
	<br />
	<h1 align="center"> 메인 페이지 </h1>
	<table>
		<tr>
			
			<td rowspan="2">
				<a href="boardList.jsp" >게시판</a>
			</td>
			<td> <%=id %> 님 환영합니다 <br /> 
				<button onclick="window.location='logout.jsp'">로그아웃</button> <br />
				<button onclick="window.location='modify.jsp'">회원정보변경</button> <br />
				<%if(id.equals("admin")){ %>
				<button onclick="window.location='memberList.jsp'">회원리스트</button> <br />
				<%} %>
			</td>
		</tr>
	</table>
	<br /><br /><br /><br />
	<div align="center">
		<img src="img/beach.jpg" width="800" />
	</div>
</body>
<%	} %>
</html>