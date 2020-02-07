<%@page import="web.project.model.FishDTO"%>
<%@page import="web.project.model.FishDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style3.css" rel="stylesheet" type="text/css">
	<style>
		.table5{
			width: 100%;
			margin-right: auto;
			margin-left: auto;
			padding:5px;
			overflow:hidden;
			background-color: #d9d9d9;
		}	
	</style>
</head>
<jsp:include page="mHeader.jsp"/>
<%
	String id = "";
	if(session.getAttribute("memId") != null){
		id = (String)session.getAttribute("memId");
	}
	// 글 1개에 해당하는 내용을 화면에 뿌려주기.
	// 파라미터는 문자열로만 넘어오기 때문에 숫자로 형변환 해줘야한다.
	int num = Integer.parseInt(request.getParameter("num"));
	int endRow = 0;
	if(request.getParameter("endRow") != null){
		endRow = Integer.parseInt(request.getParameter("endRow"));
	}
	// 게시판 글 목록의 몇번 페이지에서 넘어오는지 던져준 페이지 번호 값.
	String pageNum = request.getParameter("pageNum");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	// DB에서 글 고유번호로 내용 꺼내와서 DTO에 담기
	
	
	FishDAO dao = FishDAO.getInstance();
	FishDTO article =dao.getArticle(num);

	int likefish = dao.showLike(num);
	
%>
<body>
<p align="center" class="txt">야 너두 작가될 수 있어</p>
	<div class="div">
		<table class="table5">
			<tr>
				<td rowspan = "10"><img src ="/web/mSave/<%= article.getImg() %>" height = "640"/></td>
			</tr>
			<tr>
				<td> 작성자 </td>
				<td align="center" colspan="3"><%=article.getWriter()%> </td>
			</tr>
			<tr>
				<td> 제  목 </td>
				<td colspan="3"><%=article.getName()%></td>
			</tr>
			<tr>
				<td> 장  르 </td>
				<td align="center" colspan="3"><%=article.getGenre()%></td>
			</tr>
			<tr>
				<td> 책 발행일 </td>
				<td align="center" colspan="3"><%=article.getRegs() %></td> 
			</tr>
			<tr>
				<td> 내  용 </td>
				<td colspan="3"><textarea rows="20" cols="70" readonly><%=article.getContent()%></textarea> </td>
			</tr>
			<tr>
				<td> 작성 시간 </td>
				<td colspan="3"> <%=sdf.format(article.getReg())%> </td>
			</tr>
			<tr>
				<td> 클릭수 </td>
				<td><%=article.getReadcount()%> viewed</td>
				
				<td> 좋아요!</td>
				<td><%=likefish%> clicked </td>
			</tr>
				<tr>
				<td colspan="5"><!-- 온클릭시 아이피 받아서 넘어가게 ? -------------------------> 
				
					<button  onclick = "window.location.href='nBookLikePro.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'" style="color: white; background-color: black;">좋아요!</button>
					<button  onclick = "window.location.href='nBookListForm.jsp?num=<%=article.getNum() %>&pageNum=<%=pageNum%>'" style="color: white; background-color: black;">닫기</button>
					<%if(id!=null&&id.equals("admin")){ %>
					<button  onclick = "window.location.href='nBookdeletePro.jsp?num=<%=article.getNum() %>&pageNum=<%=pageNum%>&endRow=<%=endRow%>'" style="color: white; background-color: black;">삭제</button>
					<%} %>
				</td>
			</tr>
		</table>
	</div>
</body>
<jsp:include page="mFooter.jsp"/>	
</html>