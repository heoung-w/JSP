<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>글 작성</title>
	<link href="style3.css" rel="stylesheet" type="text/css">
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
	if(id.equals("admin")){
%>
<body>
	<p class="txt" align="center">글 작성 페이지</p>
	<div class="div">
		<form action="mQnAwritePro.jsp" method="post">
			<input type="hidden" name="num" value="<%=num %>">
			<table class="table1">
				<tr>
					<td>작성자</td>
					<td><input type="text" name="writer" value="<%=id %>" style="width:200px"></td>
				</tr>
				<tr>
					<td>제목</td>
					<td>
						<input type="text" name="title" style="width:200px">
					</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="email" name="email" style="width:200px"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea rows="20" cols="70" name="content"></textarea></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="저장" style="color: white; background-color: black;">
						<input type="reset" value="재작성" style="color: white; background-color: black;">
						<input type="button" value="리스트보기" onclick="window.location='mQnAForm.jsp'" style="color: white; background-color: black;">
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