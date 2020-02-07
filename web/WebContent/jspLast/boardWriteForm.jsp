<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 작성</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	// # 로그인 상태 확인하고 페이지 처리
	if(session.getAttribute("memId") == null) { %>
		<script>
			alert("로그인 후 이용 가능");
			window.location="loginForm.jsp?pageNum=1&from=boardList";
		</script>	
<%	}// # 세션X 쿠키 있는건 알아서 처리하기

	// # 작성자 id로 지정하기
	String id = "";
	if(session.getAttribute("memId") != null){
		id = (String)session.getAttribute("memId");
	}
	
	
	int num = 0, ref = 1, re_step = 0, re_level = 0;
	
	if(request.getParameter("num") != null){
		num = Integer.parseInt(request.getParameter("num"));
		ref = Integer.parseInt(request.getParameter("ref"));
		re_step = Integer.parseInt(request.getParameter("re_step"));
		re_level = Integer.parseInt(request.getParameter("re_level"));
	}
	
%>
<body onload="focusIt()">
	<br />
	<h1 align="center"> Write Article </h1>
	<form action="boardWritePro.jsp" method="post" name="inputForm">
		<%-- 숨겨서 글속성 전송 --%>
		<input type="hidden" name="num" value="<%=num %>" />
		<input type="hidden" name="ref" value="<%=ref %>" />
		<input type="hidden" name="re_step" value="<%=re_step %>" />
		<input type="hidden" name="re_level" value="<%=re_level %>" />
		<table>
			<tr>	
				<td></td>
				<td align="right">
					<input type="button" value="리스트 보기" onclick="window.location='boardList.jsp'" /> 
				</td>
			</tr>
			<tr>
				<td> 작성자 * </td>
				<td align="left"> <%=id %>
					<input type="hidden" name="writer" value="<%=id %>" /> 
				</td>
				
			</tr>
			<tr>
				<td> 제  목 * </td>
				<td align="left">
				<%if(request.getParameter("num") == null){ %> 
					<input type="text" name="subject" /> 
				<%}else{ %>
					<input type="text" name="subject" value="[답변]" /> 
				<%} %>
				</td>
			</tr>
			<tr>
				<td> e-mail * </td>
				<td align="left"> <input type="text" name="email" /> </td>
			</tr>
			<tr>
				<td> 내  용 </td>
				<td> <textarea rows="20" cols="70" name="content"></textarea> </td>
			</tr>
			<tr>
				<td> 비밀번호 </td>
				<td align="left"> <input type="password" name="pw" /> </td>
			</tr>
			<tr>
				<td colspan="2" align="right"> 
					<input type="submit" value="저장" /> 
					<input type="reset" value="재작성" /> 
					<input type="button" value="리스트 보기" onclick="window.location='boardList.jsp'" /> 
				</td>
			</tr>
		</table>
	</form>
</body>
</html>