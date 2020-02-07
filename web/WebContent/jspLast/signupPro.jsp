<%@page import="web.jspLast.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.sql.Timestamp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>signup pro</title>
</head>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="member" class="web.jspLast.model.MemberDTO" /> 
<%
	
	if(session.getAttribute("memId") != null) {
		response.sendRedirect("main.jsp");
	}
	
	if(session.getAttribute("memId") == null){
		String id = null, pw = null, auto = null; 
		Cookie [] cs = request.getCookies();
		if(cs != null){		
			for(Cookie coo : cs){
				if(coo.getName().equals("autoId")) id = coo.getValue();
				if(coo.getName().equals("autoPw")) pw = coo.getValue();
				if(coo.getName().equals("autoCh")) auto = coo.getValue();
			}
		}
		
		if(auto != null && id != null && pw != null){
			response.sendRedirect("loginPro.jsp");
		}else{ 
%>
<%
	
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
	member.setPhoto(mr.getFilesystemName("photo"));

	
	MemberDAO dao = MemberDAO.getInstance();
	dao.insertMember(member);
	
	response.sendRedirect("main.jsp");	
%>

<%	
		}
	}
%>
<body>

</body>
</html>