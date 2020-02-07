<%@page import="web.project.model.MemberDTO"%>
<%@page import="web.project.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>내 포인트 조회 페이지</title>
	<link href = "style3.css" rel = "stylesheet" type = "text/css"/>
	<style>
		.table4{
		width:95%;
		margin-right: auto;
		margin-left: auto;
		margin-bottom:0;
		/* border:5px solid #333; */
		padding:5px;
		overflow:hidden;
		background-color: #d9d9d9;
	}			
	</style>
	<script>	    
	    function pointup() {
			window.open("")
		}    
	</script>
</head>
<%
	if(session.getAttribute("memId") == null){ %>
		<script>
			alert("로그인후 이용해주세요!!");
			window.location.href="mLoginForm.jsp";
		</script>
	<% } else { 
		String id = (String)session.getAttribute("memId");
		MemberDAO dao = new MemberDAO();
		MemberDTO article = dao.getMember(id);
%>		
<body>
	<p class="txt" style="color:white;font-size:20px;" align ="center">보유 포인트 : <%=article.getMoney() %>원</p>
	<div class="table4">
		<form action="mMyPointPro.jsp" style="color:black;font-size:20px;"align ="left">
			<input type="radio" name="point" value="5000">5000원<br/>
			<input type="radio" name="point" value="10000">10000원<br/>
			<input type="radio" name="point" value="15000">15000원<br/>
			<input type="radio" name="point" value="20000">20000원<br/>
			<input type="submit" value="충전" style="color: white; background-color: black;"/>
			<input type="button" value="취소" onclick="history.go(-1)" style="color: white; background-color: black;"/>
		</form>
	</div>
</body>
<% } %>
<jsp:include page="mFooter.jsp"/>	
</html>