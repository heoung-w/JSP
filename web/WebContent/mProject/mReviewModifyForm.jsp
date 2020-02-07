<%@page import="web.project.model.ReviewDTO"%>
<%@page import="web.project.model.ReviewDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>mReviewModifyForm</title>
	<link href = "style3.css" rel = "stylesheet" type = "text/css"/>
</head>
<jsp:include page="mHeader.jsp"/>
<%
	if(session.getAttribute("memId") == null){ %>
			<script>
			   alert("로그인 해주세요!!");
			   window.location.href="mLoginForm.jsp";
			</script>
	<%}else{

			int num = Integer.parseInt(request.getParameter("num"));//리뷰 고유 넘버를 받아온다.
			
			String id = "";
			if(session.getAttribute("memId") != null){
				id = (String)session.getAttribute("memId");
			} 
			// DB에서 글 고유번호로 내용 꺼내와서 DTO에 담기
			ReviewDAO dao = ReviewDAO.getInstance();
			ReviewDTO review = dao.getReview(num);
		%>
	<body>
		<p class="txt" align="center">리뷰 수정</p>
		<div class="div">
			<form action="mReviewModifyPro.jsp?num=<%=review.getNum()%>&id=<%=id %>" method="post">
				<table class="table1" style="padding:10px; width: 40%">	
					<tr>
						<td>No. </td>
						<td><%=review.getNum()%></td>
					</tr>
					<tr>
						<td>작성자</td> 
						<td><%=review.getId()%></td>
					</tr>
					<tr>
						<td>리뷰 내용</td> 
						<td><input type="text" name="recontent" value="<%=review.getRecontent()%>" /></td>
					</tr>
					<tr>
						<td>평   점</td>
						<td>
							<input type="radio" name="star" value="★"/>★(1점)
							<input type="radio" name="star" value="★★"/>★★(2점)
							<input type="radio" name="star" value="★★★"/>★★★(3점)
							<input type="radio" name="star" value="★★★★"/>★★★★(4점)
							<input type="radio" name="star" value="★★★★★"/>★★★★★(5점)
						</td>
					</tr>
					<tr>
						<td> 작성 시간 </td>
						<td><%=review.getBk_rereg()%></td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<input type="submit" value="수정" style="color: white; background-color: black;"/>
							<input type="button" value="취소" onclick="window.location='mMyReviewForm.jsp'" style="color: white; background-color: black;"/>
						</td>
					</tr>
				</table>		
			</form>
		</div>
	</body>
<% } %>
<jsp:include page="mFooter.jsp"/>	
</html>