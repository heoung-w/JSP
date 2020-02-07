<%@page import="web.jspLast.model.BoardDTO"%>
<%@page import="web.jspLast.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>글 수정</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>

<%
	//# 로그인 상태 확인하고 페이지 처리
	if(session.getAttribute("memId") == null) { %>
		<script>
			alert("로그인 후 이용 가능");
			window.location="loginForm.jsp?pageNum=1&from=boardList";
		</script>	
<%	}else{// # 세션X 쿠키 있는건 알아서 처리하기. 

	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	// 글 DB에서 가져오기
	BoardDAO dao = BoardDAO.getInstance();
	BoardDTO article = dao.getArticle(num);
	
%>

<body>
	<br />
	<h1 align="center"> edit article</h1>
	<form action="boardModifyPro.jsp?pageNum=<%=pageNum%>" method="post" name="inputForm" >
		<table>
			<tr>
				<td> 작성자 * </td>
				<td align="left"> <input type="text" name="writer" value="<%=article.getWriter()%>" /> </td>
			</tr>
			<tr>
				<td> 제  목 * </td>
				<td align="left">
					<input type="text" name="subject" value="<%=article.getSubject() %>" /> 
				</td>
			</tr>
			<tr>
				<td> e-mail * </td>
				<td align="left"> <input type="text" name="email" value="<%=article.getEmail() %>" /> </td>
			</tr>
			<tr>
				<td> 내  용 </td>
				<td> <textarea rows="20" cols="70" name="content"><%=article.getContent() %></textarea> </td>
			</tr>
			<tr>
				<td> 비밀번호 </td>
				<td align="left"> <input type="password" name="pw" /> </td>
			</tr>
			<tr>
				<td colspan="2" align="right"> 
					<input type="submit" value="저장" /> 
					<input type="reset" value="재작성" /> 
					<input type="button" value="리스트 보기" onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" /> 
				</td>
			</tr>
		</table>
		<%-- 글 고유번호 hidden으로 처리 --%>
		<input type="hidden" name="num" value="<%=article.getNum()%>" />
	</form>

</body>
<%} %>
</html>