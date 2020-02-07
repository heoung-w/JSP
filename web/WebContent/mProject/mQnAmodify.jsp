<%@page import="web.project.model.QnADTO"%>
<%@page import="web.project.model.QnADAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정</title>
<link href="style3.css" rel="stylesheet" type="text/css">

</head>
<jsp:include page="mHeader.jsp"/>
<%
	request.setCharacterEncoding("UTF-8");
	
	int num = 0;
	if(request.getParameter("num") != null){
		num = Integer.parseInt(request.getParameter("num"));
	} 
	
	String pageNum=null;
	if(request.getParameter("pageNum")!=null){	
		pageNum = request.getParameter("pageNum");
	}else{
		pageNum="1";
	}
	
	String id = (String)session.getAttribute("memId");
	String admin = (String)session.getAttribute("admin");
		
	QnADAO dao = QnADAO.getInstance();
	QnADTO article = dao.getArticle(num);
	
	if(id.equals("admin")){
%>
<body>
	<p class="txt" align="center">글 수정</p>
	<div class="div">
		<form action="mQnAmodifyPro.jsp" method="post">
			<input type="hidden" name="num" value="<%=num %>">
			<input type="hidden" name="pageNum" value="<%=pageNum %>">
				<table class="table1">
					<tr>
						<td>작성자</td>
						<td><input type="text" name="writer" value="<%=article.getWriter() %>" style="width:200px"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="title" value="<%=article.getTitle() %>" style="width:200px"></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="email" name="email" value="<%=article.getEmail() %>" style="width:200px"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea rows="20" cols="70" name="content" value="<%=article.getContent() %>"></textarea></td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="submit" value="저장" style="color: white; background-color: black;">
							<input type="reset" value="재작성" style="color: white; background-color: black;">
							<input type="button" value="리스트보기" onclick="window.location='mQnAForm.jsp?pageNum=<%=pageNum %>'" style="color: white; background-color: black;">
						</td>
					</tr>
				</table>
		</form>
	</div>
</body>
<%}else{ %>
	<script>
		alert("관리자만 이용 가능합니다.");
		window.location="mQnAForm.jsp";
	</script>
<%} %>
<jsp:include page="mFooter.jsp"/>	
</html>