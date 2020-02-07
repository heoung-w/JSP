<%@page import="web.jspLast.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>ID 중복확인</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>

<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	MemberDAO dao = MemberDAO.getInstance();
	int check = dao.confirmId(id);
%>

<body>
<%
	if(check == 1){	// id가 존재하면,
%>
	<table>
		<tr>
			<td><%=id %> 이미 사용중인 아이디입니다.</td>
		</tr>
	</table>
	<form action="confirmId.jsp" method="post" name="checkForm">
	<table>
		<tr>
			<td>다른 아이디를 선택하세요. <br />
				<input type="text" name="id"  />
				<input type="submit" value="ID중복확인"  />
			</td>
		</tr>
	</table>
	</form>
<%	}else{ // id가 존재하지 않는 다면, %>
	<table>
		<tr>
			<td>입력하신 <%=id %>는 사용하실수 있는 아이디입니다. <br />
				<input type="button" value="닫기" onclick="setId()" />
			</td>
		</tr>
	</table>
<%	} %>
</body>
<script>
	
	function setId() {
		opener.document.inputForm.id.value = "<%=id%>"; 
		self.close();	// 창닫기
	}
</script>
</html>