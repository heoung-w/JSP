
<%@page import="web.project.model.BookDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mBookListInputPro</title>
</head>

<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("memId");
	String admin = (String)session.getAttribute("admin");
	
	if(id.equals("admin")){
%>
<jsp:useBean id = "article" class="web.project.model.BookDTO" />

<%
	String path = request.getRealPath("mSave"); // 저장할 파일 경로
	int max = 1024*1024*10;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);%>
<%
	article.setName(mr.getParameter("name"));
	article.setImg(mr.getFilesystemName("img"));
	article.setPrice(Integer.parseInt(mr.getParameter("price")));
	article.setGenre(mr.getParameter("select"));
	article.setWriter(mr.getParameter("writer"));
	article.setPublisher(mr.getParameter("publisher"));
	article.setContent(mr.getParameter("content"));
	article.setRegs(mr.getParameter("date")); 
	String names = mr.getParameter("name");
	
	BookDAO dao =BookDAO.getInstance();
	dao.insertBook(article);
%>
<script>
	alert(<%=names %>+"책이 등록되었습니다.");
</script>	
<% 	
	response.sendRedirect("mBookListForm.jsp");
%>

	<%}else{%>
		<script>
				alert("관리자만 이용 가능합니다.");
				window.location="mMain.jsp";
		</script>
	<% }%>

<body>
</body>
</html> 