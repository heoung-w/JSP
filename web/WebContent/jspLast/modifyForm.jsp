<%@page import="web.jspLast.model.MemberDTO"%>
<%@page import="web.jspLast.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Modify Form</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	// 로그인상태가 아니면 로그인 페이지로 이동
	if(session.getAttribute("memId") == null){ 	
%>		<script>
			alert("로그인 해주세요.");
			window.location="/web/jsp11/loginForm.jsp";
		</script>
		
<%	//로그인상태이면
	}else{
		
		String id = (String)session.getAttribute("memId");
		
		
		MemberDAO dao = MemberDAO.getInstance();
		MemberDTO member = dao.getMember(id);
%>	
<body>
	<br />
	<h1 align="center"> 회원정보 수정 </h1>
	<form action="modifyPro.jsp" method="post" enctype="multipart/form-data"  name="inputForm" >	
		<table>
			<tr>
				<td>아이디*</td>
				<td><%=member.getId() %></td>
			</tr>
			<tr>
				<td>비밀번호*</td> 
				<td><input type="password" name="pw" value="<%=member.getPw() %>" /></td>
			</tr>
			<tr>
				<td>비밀번호 확인*</td>
				<td><input type="password" name="pwCh" /></td>
			</tr>
			<tr>
				<td>이름*</td>
				<td><%=member.getName() %></td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td>
				<%if(member.getBirth()==null){ %>
					<input type="text" name="birth" maxlength="8" />
				<%}else{ %>
					<input type="text" name="birth" maxlength="8" value="<%=member.getBirth()%>" />
				<%} %>
				</td>
			</tr>
			<tr>
				<td>e-mail</td>
				<td>
				<%if(member.getEmail()==null){ %>
					<input type="text" name="email"  />
				<%}else{ %>
					<input type="text" name="email" value="<%=member.getEmail() %>" />
				</td>
				<%} %>
			</tr>
			<tr>
				<td>photo</td>
				<td>
				<%if(member.getPhoto() == null){ %>
					<img src="img/default_img.jpg"  width="100" /> <br />
				<%}else{ %>
					<img src="/web/save/<%=member.getPhoto()%>"  width="100" /> <br />
				<%} %>
					<input type="file" name="photo" />
					<input type="hidden" name="exPhoto" value="<%=member.getPhoto()%> "/>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="수정" />
					<input type="button" value="취소" onclick="window.location='main.jsp'"/>
				</td>
			</tr>
		</table>
	</form>
</body>
<%	}%>
</html>