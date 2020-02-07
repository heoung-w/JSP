<%@page import="web.project.model.MemberDAO"%>
<%@page import="web.project.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	if(session.getAttribute("memId") == null){ %>
	
		<script>
			alert("로그인후 이용해주세요!!");
			window.location.href="mLoginForm.jsp";
		</script>
	
  <%}else{ 
	
		   String id = (String)session.getAttribute("memId");
		   String myPoint = request.getParameter("point");
		   if(myPoint == null){ %>
		      <script>
		         alert("충전금액을 선택해 주세요");
		         history.go(-1);
		      </script>
		<%}else{
		         int point = Integer.parseInt(request.getParameter("point"));
		         MemberDAO dao=new MemberDAO();
		         int result = dao.updatePoint(id, point);//update가 잘되면 1을 result값에 넣어서
		         
		         if(result==1){%>
			            <script>
			            alert("충전 성공");
			            window.close();
			            </script>      
		         <%}else {%>
			            <script>
			            alert("충전 실패");
			            history.go(-1);
			            </script>
		         <%} 
		  }%>
</body>
   <%}%>
</html>