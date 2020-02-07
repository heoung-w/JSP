<%@page import="web.jspLast.model.BoardDTO"%>
<%@page import="web.jspLast.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>글 내용</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	// # 로그인 안하면 못들어오게 
	if(session.getAttribute("memId") == null) { %>
		<script>
			alert("로그인 후 글 읽기 가능");
			window.location="loginForm.jsp?pageNum=1&from=boardList";		
		</script>	
<%	}else{

	// 글 고유번호와 페이지 받기
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	// 작성시간 보여줄 포맷 지정
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	
	// # 아이디 받아와서 본인일경우만 수정/삭제 가능하게하기
	String id = (String)session.getAttribute("memId");
	
	// 글 고유번호로 DB에서 글 꺼내와 DTO로 담기
	BoardDAO dao = BoardDAO.getInstance();
	BoardDTO article = dao.getArticle(num);
%>

<body>
	<br />
	<h1 align="center"> content </h1>
	<table>
		<tr>
			<td colspan="2"><b><%=article.getSubject() %></b></td>
		</tr>
		<tr>
			<%-- 내용 --%>
			<td colspan="2" height="100"><%=article.getContent() %></td>
		</tr>
		<tr>
			<td>posted by <a href="mailto:<%=article.getEmail() %>"><b><%=article.getWriter()%></b></a> at <%=sdf.format(article.getReg())%></td>
			<td><%=article.getReadcount() %> viewed</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<%-- # 본인또는 admin(관리자)만 수정 삭제 가능하게 --%>
				<%if(article.getWriter().equals(id) || article.getWriter().equals("admin")){ %>
				<%-- 수정 버튼 modifyForm으로 링크걸기 (글고유번호와 페이지 번호 함께)  --%>
				<button onclick="window.location='boardModifyForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">수  정</button>
				<button onclick="window.location='boardDeleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">삭  제</button>
				<%} %>
				<%-- 답글 버튼 처리 : num, ref, re_step, re_level DB에서 받은정보 보내주면서 이동--%>
				<button onclick="window.location='boardWriteForm.jsp?num=<%=num%>&ref=<%=article.getRef()%>&re_step=<%=article.getRe_step()%>&re_level=<%=article.getRe_level()%>'">답  글</button>
				<% String from = request.getParameter("from"); %>
				<button onclick="window.location='<%=from%>.jsp?pageNum=<%=pageNum%>'">리스트</button>
			</td>
		</tr>
	</table>
</body>
<%} %>
</html>