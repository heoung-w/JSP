<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>글 삭제</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	// # 로그인 상태 확인하고 페이지 처리
	if(session.getAttribute("memId") == null) { %>
		<script>
			alert("로그인 후 이용 가능");
			window.location="loginForm.jsp?pageNum=1&from=boardList";
		</script>	
<%	}else{// # 세션X 쿠키 있는건 알아서 처리하기.


	// 넘어올때 던져준 글 고유번호 num, 페이지 번호 pageNum 받기
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
%>
<body>
	<br />
	<h1 align="center"> delete article </h1>
	<form action="boardDeletePro.jsp?pageNum=<%=pageNum%>" method="post" >
		<table>
			<tr>
				<td> 삭제를 원하시면 비밀번호를 입력하세요. </td>
			</tr>
			<tr>
				<td> 
					<input type="password" name="pw" />
				</td>
			</tr>
			<tr>
				<td> 
					<input type="submit" value="삭제" />
					<input type="button" value="취소" onclick="window.location='boardList.jsp?pageNum=<%=pageNum%>'" />
				</td>
			</tr>
		</table>
		<%-- 글 고유번호 숨겨서 데이터 보내기 --%>
		<input type="hidden" name="num" value="<%=num%>" />
	</form>
</body>
<%} %>
</html>