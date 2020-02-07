<%@page import="web.jspLast.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Delete Pro</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	request.setCharacterEncoding("UTF-8");

	//로그인상태가 아니면 로그인 페이지로 이동
	if(session.getAttribute("memId") == null){ 	
%>		<script>
			alert("로그인 해주세요.");
			window.location="/web/jsp12/loginForm.jsp";
		</script>
		
<%	//로그인상태이면
	}else{

		String id = (String)session.getAttribute("memId");
		String pw = request.getParameter("pw");
	
		MemberDAO dao = MemberDAO.getInstance();
		int check = dao.deleteMember(id, pw);
		
		// 회원정보 삭제가 잘 진행되었다면 세션도 지우고 메세지 태그로 띄우기
		if(check == 1) {
			session.invalidate();
%>
<body>
	<table>
		<tr>
			<td>회원 정보가 삭제 되었습니다.</td>
		</tr>
		<tr>
			<td><button onclick="window.location='main.jsp'">메인으로 돌아가기</button></td>
		</tr>
	</table>
</body>
<%		}else{%>
			<script>
				alert("비밀번호가 맞지 않습니다.");
				history.go(-1);
			</script>
<%		}
} %>
</html>