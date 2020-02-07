<%@page import="web.project.model.QnADTO"%>
<%@page import="web.project.model.QnADAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>글 내용</title>
	<link href="style3.css" rel="stylesheet" type="text/css">

</head>
	<jsp:include page="mHeader.jsp"/>
<% if(session.getAttribute("memId")==null){%>
	<script>
		alert("로그인 후 이용 가능");
		history.go(-2);
	</script>
<%}
	String id = "";
	if(session.getAttribute("memId") != null){
		id = (String)session.getAttribute("memId");
	}
	// 글 한 개에 해당하는 내용을 화면에 뿌려줌.
	// 파라미터는 문자열로만 넘어온다. 숫자로 필요하면 형변환 해주기
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	
	// DB에서 글 고유번호로 내용 꺼내와서 pro에 담기
	QnADAO dao = QnADAO.getInstance();
	QnADTO article = dao.getArticle(num);
%>
<body>
	<p class="txt" align="center">QnA</p>
	<div class="div">
		<table class="table" style="width: 50%;">
			<tr>
				<td>작성자</td>
				<td><%=article.getWriter() %></td>
			</tr>
			<tr>
				<td align="center">제목</td>
				<td><%=article.getTitle() %></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="20" cols="70" readonly><%=article.getContent() %></textarea></td>
			</tr>
			<tr>
				<td colspan="2">posted by <a href="mailto:<%=article.getEmail() %>"><%=article.getWriter() %></a> at <%=sdf.format(article.getReg()) %></td>
			</tr>
			<tr>
				<td colspan="2"><%=article.getRead_count() %> viewed</td>
			</tr>
			<tr>
				<td colspan="2">
					<%if(id!=null&&id.equals("admin")) {%>
					<button onclick="window.location='mQnAmodify.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">수   정</button>
					<button onclick="window.location='mQnAdeletePro.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">삭   제</button>				
					<%} %>
					<button onclick="window.location='mQnAForm.jsp?pageNum=<%=pageNum %>'">QnA 목록</button>
				</td>
			</tr>		
		</table>
	</div>
</body>
<jsp:include page="mFooter.jsp"/>	
</html>