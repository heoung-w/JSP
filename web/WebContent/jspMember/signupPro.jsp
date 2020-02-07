<%@page import="web.jspMember.model.memberDTO"%>
<%@page import="java.io.File"%>
<%@page import="web.jspMember.model.memberDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signupPro</title>
</head>
<% request.setCharacterEncoding("UTF-8"); %>

<%
	String path = request.getRealPath("save");
	int max = 1024*1024*5;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	
	System.out.println(request.getRealPath("save"));
	
	String sysName = mr.getFilesystemName("photo");
	String cotentType = mr.getContentType("photo");
	String[] ct = cotentType.split("/");
	if(!ct[0].equals("image")){
		File f = new File(sysName);
		f.delete();
	%>	
	<script type="text/javascript">
		alert("이미지파일을 업로드하세요.");
		history.go(-1);
	</script>
	<% 
	}
	memberDTO member = new memberDTO();
	member.setId(mr.getParameter("id"));
	member.setPw(mr.getParameter("pw"));
	member.setName(mr.getParameter("name"));
	member.setPhone(mr.getParameter("phone"));
	member.setBirth(mr.getParameter("birth"));
	member.setGender(mr.getParameter("gender"));
	member.setEmail(mr.getParameter("email"));
	member.setPhoto(sysName);
	
	memberDAO dao = new memberDAO();
	dao.insertMember(member);
	
	response.sendRedirect("main.jsp");

%>
<body>



</body>
</html>