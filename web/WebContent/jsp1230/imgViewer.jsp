<%@page import="java.util.List"%>
<%@page import="web.jspsave.model.UploadDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");

	String writer = request.getParameter("writer");
	
	UploadDAO dao = new UploadDAO();
	List imgList = dao.getImg(writer);
%>
<body>
<h1> img viewer</h1>
<%for(int i = 0; i < imgList.size(); i++){ %>
<h2> 작성자 : <%=writer %></h2>
<img src="/web/save/<%=imgList.get(0) %>"/>
<%} %>
</body>
</html>