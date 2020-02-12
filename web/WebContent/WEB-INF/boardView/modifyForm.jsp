<%@page import="web.jspBoard.model.BoardDTO"%>
<%@page import="web.jspBoard.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>글 수정</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	// 글고유 번호
	int num = Integer.parseInt(request.getParameter("num"));
	// list에서 보던 페이지 번호
	String pageNum = request.getParameter("pageNum");	


	// 해당 글의 내용을 DB에서 가져오기
	BoardDAO dao = new BoardDAO();
	BoardDTO article = dao.getArticle(num);

%>

<body>
	<br />
	<h1 align="center"> 글 수정 </h1>
	<form action="modifyPro.jsp?pageNum=<%=pageNum%>" method="post">
		<%-- 숨겨서 글 속성에 관련된 데이터 전송 --%>
		<input type="hidden" name="num" value="<%=num%>" />
		<table>
			<tr>
				<td> 작성자 </td>
				<td align="left"> 
					<input type="text" name="writer" value="<%=article.getWriter()%>" /> 
				</td>
			</tr>
			<tr>
				<td> 제   목 </td>
				<td align="left">
					<input type="text" name="subject" value="<%=article.getSubject()%>"/> 
				</td>
			</tr>
			<tr>
				<td> e-mail </td>
				<td align="left"> 
					<input type="text" name="email" value="<%=article.getEmail()%>"/> 
				</td>
			</tr>
			<tr>
				<td> 내   용 </td>
				<td> <textarea rows="20" cols="70" name="content"><%=article.getContent()%></textarea> </td>
			</tr>
			<tr>
				<td> 비밀번호 </td>
				<td align="left"> <input type="password" name="pw" /> </td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="저장" />
					<input type="reset" value="재작성" />
					<input type="button" value="리스트보기" onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
				</td>
			</tr>
		</table>
	</form>
	


</body>
</html>