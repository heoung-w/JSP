<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="web.jspImgmember.model.MemberDAO"%>
<%@page import="web.jspImgmember.model.MemberDTO"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 정보 수정</title>
	<link href="style.css" rel="stylesheet" type="text/css" >
</head>
<%
	if(session.getAttribute("memId") == null) { %>
		<script>
			alert("로그인 해주세요!");
			window.location.href="loginForm.jsp";
		</script>
		
<%	}else{	// 로그인 된 상태

		// 로그인 된 상태에서 실행 == session에 memId 존재
		// DB에 접속해서 회원의 정보를 모두 긁어와 화면에 뿌려주기
		// session에 저장된 사용자의 id 꺼내기
		String id = (String)session.getAttribute("memId");
	
		MemberDAO dao = MemberDAO.getInstance();
		MemberDTO member = dao.getMember(id);

%>

<body>
	<br />
	<h1 align="center">회원 정보 수정</h1>
	<form action="modifyPro.jsp" method="post" enctype="multipart/form-data">
	<table>
		<tr>
			<td>아이디 * </td>
			<td><%=member.getId() %></td>
		</tr>
		<tr>
			<td>비밀번호 * </td>
			<td><input type="password" name="pw" value="<%=member.getPw()%>"/></td>
		</tr>
		<tr>
			<td>비밀번호 확인 * </td>
			<td><input type="password" name="pwCh" /></td>
		</tr>
		<tr>
			<td>이름 * </td>
			<td><%=member.getName() %></td>
		</tr>
		<tr>
			<td>생년월일</td>
			<td>
			<%if(member.getBirth()==null){ %>
				<input type="text" name="birth" maxlength="8" />
			<%}else{ %>	
				<input type="text" name="birth" maxlength="8" value="<%=member.getBirth()%>"/>
			<%} %>
			</td>
		</tr>
		<tr>
			<td>Email </td>
			<td>
			<%if(member.getEmail() == null){ %>
				<input type="text" name="email" />
			<%}else{ %>
				<input type="text" name="email" value="<%=member.getEmail()%>"/>
			<%} %>
			</td>
		</tr>
		<tr>
			<td>Photo </td>
			<td>
				<%if(member.getPhoto() == null){ %>
					<img src="img/default.png" width="100" /> <br />
				<%}else{%>
					<img src="/web/save/<%=member.getPhoto()%>" width="100" /> <br />
				<%} %>
				<input type="file" name="photo" />
				<input type="hidden" name="exPhoto" value="<%=member.getPhoto()%>"/>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="수정" />
				<input type="button" value="취소" onclick="window.location.href='main.jsp'" /> 
			</td>
		</tr>
	</table>
	</form>
</body>

<%	} %>

</html>