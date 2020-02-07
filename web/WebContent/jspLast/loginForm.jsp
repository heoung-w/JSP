<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>			
<%
	// # 이전 페이지에서 보낸 정보 담기
	String pageNum = "";
	String from = "";
	String uri = "";
	if(request.getParameter("pageNum") != null){
		pageNum = request.getParameter("pageNum");
		from = request.getParameter("from");
	}
	
	if(!from.equals("")){
		uri = from+".jsp?pageNum="+pageNum;
	}else{
		uri = "main.jsp";
	}
	
	// # 세션이 없는 상태
	if(session.getAttribute("memId") == null){ 
		String id = null;
		String pw = null;
		String auto = null;

		Cookie [] cookies = request.getCookies();
		if(cookies != null){
			for(Cookie coo : cookies){
				if(coo.getName().equals("autoId")) id = coo.getValue();
				if(coo.getName().equals("autoPw")) pw = coo.getValue();
				if(coo.getName().equals("autoCh")) auto = coo.getValue();
			}
		}
		// # 쿠키가 있으면 바로 이동 
		if(auto != null && id != null && pw != null){ %>
			<script>
				window.location='<%=uri%>';
			</script>
<%		}
		// #아래는 세션과 쿠키가 모드 없을 경우 로그인 처리
%>		
		<body>	
			<br />
			<h2 align="center"> 로그인 </h2>
			<table name="TABLE">
				
				<form action="loginPro.jsp?pageNum=<%=pageNum%>&from=<%=from%>" method="post" name="inputForm" >
				<tr>														
					<td>아이디</td>
					<td><input type="text" name="id" /></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pw" /></td>
				</tr>
				<tr>
					<td colspan="2"><input type="checkbox" name="auto" value="1" />자동 로그인 </td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="로그인" />
					<input type="button" value="회원가입" onclick="window.location='signupForm.jsp'" /></td>
				</tr>
				</form>
			</table>
		</body>
<%	}else{
	// # 마지막으로 세션이 있는 상태
%>
	<script>
		window.loacation='<%=uri%>';
	</script>		
<%} %>
</html>