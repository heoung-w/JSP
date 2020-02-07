<%@page import="web.project.model.BookDTO"%>
<%@page import="web.project.model.BookDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>mBookModifyForm</title>
	<link href = "style3.css" rel = "stylesheet" type = "text/css"/>
</head>
<jsp:include page="mHeader.jsp"/>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("memId");
	String admin = (String)session.getAttribute("admin");
	
	int num = 0;
	if(request.getParameter("num") != null){
		num = Integer.parseInt(request.getParameter("num"));
	}

	String pageNum = null;
	if(request.getParameter("pageNum") != null){
		pageNum = request.getParameter("pageNum");
	} 
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	// DB에서 글 고유번호로 내용 꺼내와서 DTO에 담기
	BookDAO dao = BookDAO.getInstance();
	BookDTO article = dao.getArticle(num);
	
	if(id.equals("admin")){
%>
<body>
	<p class="txt" align="center">책 수정</p>
	<div class="div">
	<form action="mBookModifyPro.jsp?num=<%=article.getNum() %>" method="post" enctype="multipart/form-data">
		<table class="table1">	
			<tr>
				<td>photo</td>
				<td align="center">
				<%if(article.getImg() == null){ %>
					<img src="img/default_img.jpg"  width="100" /> <br />
				<%}else{ %>
					<img src="/web/mSave/<%=article.getImg()%>"  width="100" /> <br />
				<%} %>
					<input type="file" name="img" />
					<input type="hidden" name="exImg" value="<%=article.getImg()%>"/>
				</td><td></td>
			</tr>
			<tr>
				<td>작가</td>
				<td><%=article.getWriter()%></td>
				<td></td>
			</tr>
			<tr>
				<td>제목</td> 
				<td><input type="text" name="name" value="<%=article.getName()%>" /></td>
				<td></td>
			</tr>
			<tr>
				<td>장르</td>
				<td><%=article.getGenre()%></td>
				<td></td>
			</tr>
			<tr>
				<td>가격</td> 
				<td><input type="text" name="price" value="<%=article.getPrice() %>" /></td>
				<td></td>
			</tr>
			<tr>
				<td>출판사</td> 
				<td><input type="text" name="publisher" value="<%=article.getPublisher()%>" /></td>
				<td></td>
			</tr>
			<tr>
				<td>발행일</td>
				<td><%=article.getRegs()%></td>
				<td></td>
			</tr>
			<tr>
				<td>내용</td> 
				<td><input type="text" name="content" value="<%=article.getContent()%>" /></td>
				<td></td>
			</tr>
			<tr>
				<td> 작성 시간 </td>
				<td> <%=sdf.format(article.getReg())%> </td>
				<td></td>
			</tr>
			<tr>
				<td> 클릭수 </td>
				<td><%=article.getReadcount()%>viewed</td>
				<td></td>

			</tr>
			<tr>
				
				<td colspan="3" align="center">
					<input type="submit" value="수정" style="color: white; background-color: black;"/>
					<input type="button" value="취소" onclick="window.location='mBookListForm.jsp'" style="color: white; background-color: black;"/>
				</td>
				
			</tr>
		</table>
	</form>
	</div>
</body>
<%}else{ %>
		<script>
				alert("관리자만 이용 가능합니다.");
				window.location="mBookListForm.jsp";
		</script>
<% } %>
<jsp:include page="mFooter.jsp"/>
</html>