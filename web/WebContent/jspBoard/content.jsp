<%@page import="web.jspBoard.model.BoardDTO"%>
<%@page import="web.jspBoard.model.BoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>글 내용</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	// 글 1개에 해당하는 내용을 화면에 뿌려주기.
	// 파라미터는 문자열로만 넘어온다. 숫자로 필요하면 형변환 해주기.
	int num = Integer.parseInt(request.getParameter("num"));
	// 게시판 글목록의 몇번 페이지에서 넘어오는지 던져준 페이지번호값.
	String pageNum = request.getParameter("pageNum");	
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	
	// DB에서 글 고유 번호로 내용 꺼내와서 DTO에 담기.
	BoardDAO dao = new BoardDAO();
	BoardDTO article = dao.getArticle(num);
%>
<body>
	<br />
	<h1 align="center"> content </h1>
	
	<table>
		<tr>
			<td> 작성자 </td>
			<td align="center" colspan="3"><%=article.getWriter()%> </td>
		</tr>
		<tr>
			<td> 제   목 </td>
			<td colspan="3"><%=article.getSubject()%></td>
		</tr>
		<tr>
			<td> e-mail </td>
			<td align="center" colspan="3">posted by <a href="mailto:<%=article.getEmail()%>"><%=article.getEmail()%></td>
		</tr>
		<tr>
			<td> 내  용 </td>
			<td colspan="3"><textarea rows="20" cols="70" readonly><%=article.getContent()%></textarea> </td>
		</tr>
		<tr>
			<td> 작성 시간 </td>
			<td> <%=sdf.format(article.getReg())%> </td>
			<td> 클릭수 </td>
			<td><%=article.getReadcount() %> viewed</td>
		</tr>
		<tr>
			<td colspan="4" align="right">
				<button onclick="window.location='modifyForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">수   정</button>
				<button onclick="window.location='deleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">삭   제</button>
				<%-- 답글버튼처리 : num,ref,re_step,re_level DB에서 받은정보 보내주면서 이동 --%>
				<button onclick="window.location='writeForm.jsp?num=<%=num%>&ref=<%=article.getRef()%>&re_step=<%=article.getRe_step()%>&re_level=<%=article.getRe_level()%>'">답   글</button>
				<button onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" >리스트</button>
			</td>
		</tr>
	</table>
	
</body>
</html>