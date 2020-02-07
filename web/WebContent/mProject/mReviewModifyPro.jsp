<%@page import="web.project.model.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mReviewModifyPro</title>
<link href = "style.css" rel = "stylesheet" type = "text/css"/>
</head>
<%  
	if(session.getAttribute("memId") == null){ %>
		<script>
		   alert("로그인 해주세요!!");
		   window.location.href="mLoginForm.jsp";
		</script>
	<%}else{
		request.setCharacterEncoding("UTF-8");
	%>

 <jsp:useBean id="review" class="web.project.model.ReviewDTO" />
 <jsp:setProperty property="*" name="review"/>

	<%
		int num = Integer.parseInt(request.getParameter("num"));//리뷰 고유번호 넘겨 받기
		String id=request.getParameter("id");
		
		ReviewDAO dao = ReviewDAO.getInstance();
		dao.updateReview(review);
		
		response.sendRedirect("mMyReviewForm.jsp");
	%>
	 
	<body>
	</body>
<% } %>
</html>