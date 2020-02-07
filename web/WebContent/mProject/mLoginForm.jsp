<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>login</title>
	<link href = "style3.css" rel ="stylesheet" type = "text/css" />
	<script type="text/javascript">
		function validate(){
			var s=document.s;
			if(!s.search.value){
				alert("검색어를 입력하세요");
				return false;
			}
		}
	</script>
</head>
<jsp:include page="mHeader.jsp"/>
<%
	// 로그인 상태이면 main 페이지로 바로 돌아가게 처리
	if(session.getAttribute("memId") != null){  %>
		<script>
			alert("이미 로그인 된 상태입니다!!")
			window.location.href="mMain.jsp";
		</script>	
<%	}else{		// memId라는 세션이 없을 경우 ==> 로그인 안된 상태
%>
<body>
	<br/>
	<p align="center" class="txt">로그인 화면</p>
	<div class="div">
		<form action = "mLoginPro.jsp" method = "post">
			<table class="table1" style="height:150px;" >
				<tr>
					<td style="color: black;">아이디</td>
					<td align="left" style="width: 40%;"><input type = "text" name ="id" style="width: 260px;"/></td>
				</tr>
				<tr>
					<td style="color: black;">비밀번호</td>
					<td align="left"><input type = "password" name ="pw" style="width: 260px;"></td>
				</tr>
				<tr>
					<td colspan = "2" align = "center">
						<input type = "submit" value = "로그인" style="color: white; background-color: black;"/>
						<input type = "button" value = "회원가입" onclick = "window.location.href='mSignupForm.jsp'" style="color: white; background-color: black;"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
<% } %>
<jsp:include page="mFooter.jsp"/>	
</html>