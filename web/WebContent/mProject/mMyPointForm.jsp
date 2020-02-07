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
	<script>
	    function pointup() {
			window.open("mMyPointCharge.jsp","","width=500,height=500,left=900,top=200");
		}	    
	</script>
</head>
	<jsp:include page="mHeader.jsp"/>
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
	<p class="txt" align="center">포인트 조회 Page</p>
	<div class="div">
		<table class="table1">
			<tr>
				<td colspan="2" style = "color:black; font-size: medium;"><b><%=article.getId() %>님</b></td>
			</tr>
			<tr>
				<td style="color:black"><b>보유 포인트 : </b></td>
				<td style="color:black"><b><%=article.getMoney() %>원</b></td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="#" onclick="return pointup()"><button type="button" >충전</button></a>
					<button onclick = "history.go(-1)" >취소</button>
				</td>
			</tr>
		</table>
	</div>
</body>
<% } %>
<jsp:include page="mFooter.jsp"/>	
</html>