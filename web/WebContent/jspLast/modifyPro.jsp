<%@page import="web.jspLast.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Modify Pro</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>

<% request.setCharacterEncoding("UTF-8"); // 대문자로 %>

<jsp:useBean id="member" class="web.jspLast.model.MemberDTO" />

<%
	//로그인상태가 아니면 로그인 페이지로 이동
	if(session.getAttribute("memId") == null){ 	
%>		<script>
			alert("로그인 해주세요.");
			window.location="/web/jsp12/loginForm.jsp";
		</script>
		
<%	//로그인상태이면
	}else{
		// MultipartRequest 생성		
		String path = request.getRealPath("save");	
		int max = 1024*1024*5;		
		String enc = "UTF-8";
		DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();	
		MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
		
		
		String id = (String)session.getAttribute("memId");
		member.setId(id);
		
		member.setPw(mr.getParameter("pw"));
		member.setBirth(mr.getParameter("birth"));
		member.setEmail(mr.getParameter("email"));
		if(mr.getFilesystemName("photo") != null){
			member.setPhoto(mr.getFilesystemName("photo"));
		}else{
			member.setPhoto(mr.getParameter("exPhoto"));
		}
		
		MemberDAO dao = MemberDAO.getInstance();
		dao.updateMember(member);	
		
	}
%>	
<body>
	<br />
	<h1 align="center"> 회원정보 수정 </h1>
	<table>
		<tr>
			<td> <b>회원정보가 수정되었습니다.</b> <br /></td>
		</tr>
		<tr>
			<td>
				<button onclick="window.location='main.jsp'"> 메인으로 </button> <br />
			</td>
		</tr>
	</table>
</body>
</html>