<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	String id = (String)session.getAttribute("memId");
	String mId = null, mPw = null, mAuto = null;
	
	if(id != null){ // 아이디가 널이 아니라면 %>
		<body>
		<h1 align = "center">메인 페이지</h1>
		<table>
			<tr>
				<td> <%=session.getAttribute("memId") %> 님 환영합니다!!  <br/>
					<button onclick = "window.location.href='modify.jsp'">개인정보수정</button>
					<button onclick = "window.location.href='logOut.jsp'">로그아웃</button>	
				</td>
			</tr>
		</table>
		<div align = "center">
			<img src= img/test.jpg width="600" height = "500"/>

</body>
<% }else{ 

		if(session.getAttribute("memId") == null){
			
			Cookie [] cs = request.getCookies();
			if(cs != null){
				for(Cookie coo : cs){
					if(coo.getName().equals("autoId")) mId = coo.getValue();
					if(coo.getName().equals("autoPw")) mPw = coo.getValue();
					if(coo.getName().equals("autoAuto")) mAuto = coo.getValue();
				}
			}
			
			if(mAuto != null && mId != null && mPw != null){
				response.sendRedirect("loginPro.jsp");
			}
	} %>
<body>
	<h1 align = "center">메인 페이지</h1>
	<table>
		<tr>
			<td> 로그인 원하시면 버튼을 누르세요 <br/>
				<button onclick = "window.location.href='loginForm.jsp'">로그인</button>	
				<button onclick = "window.location.href='signupForm.jsp'">회원가입</butoon>
			</td>
		</tr>
	</table>
	<div align = "center">
		<img src= img/test.jpg width="600" height = "500"/>
</body>
<% } %>


</html>