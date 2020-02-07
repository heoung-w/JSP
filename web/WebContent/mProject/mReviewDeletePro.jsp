<%@page import="web.project.model.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	request.setCharacterEncoding("UTF-8");
   if(session.getAttribute("memId") == null){ %>
	      <script>
	         alert("로그인 해주세요!!");
	         window.location.href="mLoginForm.jsp";
	      </script>
<% }else{
		   String id=request.getParameter("id"); 	   
		   String [] reviewChecks=request.getParameterValues("reviewCheck");
		   
		   if(reviewChecks !=null){
			   	ReviewDAO dao=ReviewDAO.getInstance();
			   	
			   	for(int i=0;i<reviewChecks.length;i++){
			   		int review=(Integer.parseInt(reviewChecks[i]));
			   		dao.deleteReview(review);
			   	}
		   		response.sendRedirect("mMyReviewForm.jsp");
		   		%>
			   <script>
			      alert("<%=id %>님의 리뷰가 삭제되었습니다");
			      history.go(-2);
			   </script>
		 <%}else{%>
			   <script>
			      alert("삭제하실 목록을 선택해 주세요!!");
			      history.go(-1);
			    </script> 
		<% } %>
<% } %>
</html> 