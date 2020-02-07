<%@page import="web.project.model.FishDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="web.project.model.FishDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mBookListInputPro</title>
</head>

<%
String id = (String)session.getAttribute("memId");

int like = 0;
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("memId")== null){
%>
		<script>
			alert("로그인 후 이용해 주세요");
			window.location.href="mMain.jsp";
		</script>
<%
	} else {
%>
<jsp:useBean id = "article" class="web.project.model.FishDTO" />

<%
	String path = request.getRealPath("mSave"); // 저장할 파일 경로
	int max = 1024*1024*10;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);%>
<%
	article.setName(mr.getParameter("name"));
	article.setImg(mr.getFilesystemName("img"));
	article.setGenre(mr.getParameter("select"));
	article.setWriter(mr.getParameter("writer"));
	article.setContent(mr.getParameter("content"));
	article.setRegs(mr.getParameter("date")); 
	
	String names = mr.getParameter("name");
	
	FishDAO dao = FishDAO.getInstance();
	dao.insertBook(article);
%>
<script>
	alert(<%=names %>+"이 등록되었습니다.");
</script>	
<% 	
	response.sendRedirect("nBookListForm.jsp");
%>


<%
}
%>
<body>

</body>
</html> 