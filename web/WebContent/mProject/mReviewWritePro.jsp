<%@page import="web.project.model.BookDTO"%>
<%@page import="web.project.model.BookDAO"%>
<%@page import="web.project.model.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mReviewWritePro</title>
<link href="style.css" rel="stylesheet" type="text/css" >
</head>
<%  
	
	request.setCharacterEncoding("UTF-8");

	//# 로그인 상태 확인하고 페이지 처리
	if(session.getAttribute("memId") == null) { %>
		<script>
			alert("로그인 후 이용 가능");
			window.location="loginForm.jsp";
		</script>	
<%	}else{
%>

<jsp:useBean id="review" class="web.project.model.ReviewDTO" />
<jsp:setProperty property="*" name="review"/>

	<% 
		int num = Integer.parseInt(request.getParameter("bk_num"));	
		//ReviewDTO에 있는 bk_num을 받는 것.
			
		//review 글 목록의 몇번 페이지에서 넘어오는지 던져준 페이지 번호 값.
		//String pageNum = request.getParameter("pageNum");	
		
		String id = "";
		if(session.getAttribute("memId") != null){
			id = (String)session.getAttribute("memId");
		}
		
		ReviewDAO dao = ReviewDAO.getInstance();
		dao.insertReview(review);
	%>
		<script>
			alert("<%=id%>님의 리뷰가 등록되었습니다.");
			history.go(-1);
		</script>
	
	<%	
		//response.sendRedirect("mContentForm.jsp");
} %>
<body>
</body>
</html>