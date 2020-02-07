<%@page import="web.project.model.BookDTO"%>
<%@page import="web.project.model.BookDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mBookModifyPro</title>
<link href = "style.css" rel = "stylesheet" type = "text/css"/>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("memId");
	String admin = (String)session.getAttribute("admin");
		
	if(id.equals("admin")){
%>

 <jsp:useBean id="book" class="web.project.model.BookDTO" />

<%
	String path = request.getRealPath("mSave");	
	int max = 1024*1024*5;		
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();	
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	
	int num = 0;
	if(request.getParameter("num") != null){
		num = Integer.parseInt(request.getParameter("num"));
	}
	book.setNum(num); 
	
	if(mr.getFilesystemName("img") !=null){
		book.setImg(mr.getFilesystemName("img"));
	}else{
		book.setImg(mr.getParameter("exImg"));
	}
	
	book.setName(mr.getParameter("name"));
	//System.out.println(mr.getParameter("name"));
	
	book.setPrice(Integer.parseInt(mr.getParameter("price")));
	//System.out.println(Integer.parseInt(mr.getParameter("price")));
	
	book.setPublisher(mr.getParameter("publisher"));
	book.setContent(mr.getParameter("content"));
		
	BookDAO dao = BookDAO.getInstance();
	dao.updateBook(book);
	response.sendRedirect("mBookListForm.jsp");
%>
 
<body>
	<br />
		<h1 align="center"> 책 수정 </h1>
		<table>
			<tr>
				<td> <b>책이 수정되었습니다.</b> <br /></td>
			</tr>
			<tr>
				<td>
					<button onclick="window.location='mBookListForm.jsp'"> 책 목록으로  </button> <br />
				</td>
			</tr>
		</table>
</body>
<%}else{ %>
		<script>
				alert("관리자만 이용 가능합니다.");
				window.location="mBookListForm.jsp";
		</script>
<% } %>
</html>