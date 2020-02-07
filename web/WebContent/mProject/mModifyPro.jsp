<%@page import="web.project.model.MemberDAO"%>
<%@page import="web.project.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
	if(session.getAttribute("memId") == null){	%>
		<script>
			alert("로그인 해주세요!");
			window.location.href="loginForm.jsp";
		</script>	
<%	}else{
		 request.setCharacterEncoding("UTF-8"); %>
		 
		<jsp:useBean id="member" class="web.project.model.MemberDTO" />
		<jsp:setProperty property="*" name="member"/>

<%
		// 넘어오는 데이터 : 비밀번호, 생년월일, email
		// form에서 id 안넘옴 : id를 알기위해 session에서 id 꺼내기
		String id = (String)session.getAttribute("memId");
		member.setId(id);	// dto에 직접 id 세팅해서 
		// db에 수정할 데이터를 dto 통으로 보내, 회원정보 수정하기.
		MemberDAO dao = new MemberDAO();
		dao.updateMember(member);
%>
<body>
	</br>
		<script>
			alert("회원정보가 수정되었습니다.!!");
			window.location.href="mMypageForm.jsp";
		</script>
	<table>
	
		<tr>
			<td> <b>회원정보가 수정되었습니다.</b><br /> </td>
		</tr>
		<tr>
			<td>
				<button onclick="window.location.href='main.jsp'" > 메인으로 </button>
			</td>
		</tr>
	</table>
</body>

<%	} %>
</html>

