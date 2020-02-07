<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 탈퇴</title>
	<link href="style3.css" rel="stylesheet" type="text/css" >
</head>
	<jsp:include page="mHeader.jsp"/>
<%
	if(session.getAttribute("memId") == null) { %>
		<script>
			alert("로그인 해주세요!!");
			window.location.href="mLoginForm.jsp";
		</script>
<%	}else{
%>
<body>
	<p class="txt" align="center"> 회원 탈퇴 </p>
	<form action="mDeletePro.jsp" method="post">
		<table class="table1"> 
			<tr>
				<td>비밀번호</td>
					<td align="left"><input type="password" name="pw" /></td>
			</tr>
			<tr>
				<td colspan ="2"><input type="submit" value="회원 탈퇴" />
				<input type="button" value="취소" onclick="window.location.href='mMain.jsp'" />
				</td>
			</tr>
		
		</table>
	</form>

</body>
<%	} %>
<jsp:include page="mFooter.jsp"/>	
</html>