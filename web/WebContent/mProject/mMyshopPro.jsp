<%@page import="web.project.model.MemberDTO"%>
<%@page import="web.project.model.MemberDAO"%>
<%@page import="web.project.model.BookDTO"%>
<%@page import="web.project.model.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mMyshopPro</title>
<link href = "style3.css" rel = "stylesheet" type = "text/css"/>

</head>
<jsp:include page="mHeader.jsp"/>

<%
	if(session.getAttribute("memId")== null){ %>
			<script>
			alert("로그인후 이용해 주세요");
			window.location.href="mLoginForm.jsp";
			</script>
	<% }else{
			request.setCharacterEncoding("UTF-8");
			String id = (String)session.getAttribute("memId");
		
			String [] bookChecks = request.getParameterValues("bookCheck");//체크박스에 담긴 책 고유번호 받기
			MemberDAO dao = new MemberDAO();
			MemberDTO dto = dao.getMember(id);
	
			if(bookChecks != null){

	%>
<body>
<br />				
<p class="txt" align = "center"> 결제창 </p>
	<div class="div">
		<table class="table1">
				<tr>
					<td colspan="3"><b style="color:black;"> <%=session.getAttribute("memId")%>님</b></td>
				</tr>
				<tr>
					<td><b>보유 포인트 : </b></td>
					<td style="color:black"><b><%=dto.getMoney() %>원</b></td>
					<td style="color:black"><button onclick = "window.location.href='mMyPointForm.jsp'">충전</button></td>
				</tr>
		</table>
	
	<br/>
	<form action ="mMyPricePro.jsp" method="post">
		<table class="table1">
				<tr>						
					<td>No.</td>
					<td>책사진</td>
					<td>제  목</td>
					<td>저  자</td>
					<td>책장르</td>
					<td>발행일</td>
					<td>책가격</td>
				</tr>
				<%	
				BookDAO bookDao =BookDAO.getInstance();
				int total=0;
				BookDTO article = null;
				String number = null;
					for(int i =0; i < bookChecks.length; i++){
						int book = Integer.parseInt(bookChecks[i]);
						article = bookDao.getArticle(book);//지정한 책 정보를 한개만 가져오는 메서드
						total+=article.getPrice();
						if(number == null){
							number = "," + String.valueOf(article.getNum()) + ",";
						}else{
							number = number + String.valueOf(article.getNum()) + ",";
						}
				%>	
						<tr>
							<td><%=article.getNum()%></td>
							<td><img width="100" height="150" src ="/web/mSave/<%=article.getImg() %>"></td>
							<td><a href = "mContentForm.jsp?num=<%=article.getNum() %>&cart=cart"><%=article.getName() %></a></td>
							<td><%=article.getWriter() %></td>
							<td><%=article.getGenre() %></td>
							<td><%=article.getRegs() %></td>
							<td><%=article.getPrice() %></td>
						</tr>
				<% } 
				int point = dto.getMoney()- total;
				%> 
				<tr>
					<td colspan ="7" style="color:black">
							총 구매가격은 <%= total %>원입니다
						</td>
					</tr>
					<tr>
						<td colspan="4" style = "color:black">
						보유 포인트 : <%=dto.getMoney() %>원 - <%=total %>원
					</td>
					<td colspan="3" style="color:black">
						구매 후 포인트 : <%=point %>원
					</td>
				</tr>
				<tr>
					<td colspan="7">
						<input type = "submit" value ="구매"/>
						<input type = "button" value ="취소" onclick = "history.go(-1)"/>
					</td>
				</tr>
		</table>
				<input type = "hidden" name = "money" value="<%=dto.getMoney() %>"/>			
				<input type = "hidden" name = "total" value="<%=total %>"/>
				<input type = "hidden" name = "number" value="<%=number %>"/>
				<input type = "hidden" name = "point" value="<%=point %>"/>
	</form>
	</div>
			
</body>
<% } else {%>
		<script>
			alert("구매하실 목록을 선택해 주세요!!");
			history.go(-1);
		</script>
	
<% }
} %>
<jsp:include page="mFooter.jsp"/>
</html>