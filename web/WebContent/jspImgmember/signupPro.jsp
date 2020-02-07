<%@page import="web.jspImgmember.model.MemberDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>signup pro</title>
</head>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="member" class="web.jspImgmember.model.MemberDTO" />

<%
	// 파일업로드 MultipartRequest
	String path = request.getRealPath("save");
	int max = 1024*1024*5;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	
	member.setId(mr.getParameter("id"));
	member.setPw(mr.getParameter("pw"));
	member.setName(mr.getParameter("name"));
	member.setBirth(mr.getParameter("birth"));
	member.setEmail(mr.getParameter("email"));
	// 사진 저장 이름 (이름이 중복되었으면 뒤에 숫자가 붙은 이름으로 DB에 저장) 
	member.setPhoto(mr.getFilesystemName("photo"));
	
	MemberDAO dao = MemberDAO.getInstance();
	dao.insertMember(member);
	
	response.sendRedirect("main.jsp");

%>

<body>

</body>
</html>