<%@page import="web.project.model.BookDAO"%>
<%@page import="web.project.model.MemberDAO"%>

<%@page import="web.project.model.BookDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>장바구니</title>
	<link href = "style3.css" rel = "stylesheet" type = "text/css"/>
	<script><!--script사용해서 => submit버튼 두 개 구분해서 페이지 넘기기  -->
		function mySubmit(index) {
			if(index==1){
				document.mMyshopForm.action='mMyshopPro.jsp';
			}
			if(index==2){
				document.mMyshopForm.action='mMyshopDeletePro.jsp';
			}
			document.mMyshopForm.submit();
		}
	</script>

</head>
	<jsp:include page="mHeader.jsp"/>
<%
	String id = (String)session.getAttribute("memId");
	
	if(id == null){ %>
		<script>
			alert("로그인후 이용해 주세요.!!")
			window.location.href="mLoginForm.jsp";
		</script>
<%	} else { 
		MemberDAO dao = new MemberDAO();
		String book_cart = dao.getCart(id);//회원 장바구니에 담긴 걸 꺼내오는 메서드
		
		String[] books = null;
		if(book_cart != null) {//꺼내온 book_cart들이 null이 아니면, ex) 책 고유번호 4,5,14,를 꺼내왔다면, 
			books = book_cart.split(",");//','를 기준으로 split해서 나눠서, 각 숫자들을 books배열에 넣음.
		} 
	%>
	<body>
		<p class="txt" align = "center">장바구니 </p>
			<form name="mMyshopForm" onsubmit="return mySubmit(index);" method="post">
				<table class="table1">
					<tr>
						<td>   </td>
						<td>No.</td>
						<td>책사진</td>
						<td>제  목</td>
						<td>저  자</td>
						<td>책장르</td>
						<td>발행일</td>
						<td>책가격</td>
					</tr>
				
					<%	// 장바구니가 0개 일 때,
					
					BookDAO bookDao=BookDAO.getInstance();
					if(book_cart == null){%>
					<tr>
						<td  colspan="8" align="center"> 
							없습니다. 
						</td>
					</tr>
					
					<% }else{
						
							for(int i =1; i < books.length; i++){//배열의 길이만큼 for문을 돌림
								int book = Integer.parseInt(books[i]);//book에는 split된 책 고유번호들이 각각 들어감.
								BookDTO article = bookDao.getArticle(book);//그래서 지정된 책 정보 가져오는 메서드 실행 가능.%>		
							<tr>
								<td>
									<input type="checkbox" name="bookCheck" value="<%=article.getNum()%>"/>
								</td>
								<td><%=article.getNum() %></td>
								<td><img width="100" height="150" src ="/web/mSave/<%=article.getImg() %>"></td>
								<td><a href = "mContentForm.jsp?num=<%=article.getNum() %>&cart=cart" style="color: black"><%=article.getName() %></a></td>
								<td><%=article.getWriter() %></td>
								<td><%=article.getGenre() %></td>
								<td><%=article.getRegs() %></td>
								<td><%=article.getPrice() %></td>
							</tr>
									
							<% }%>
					<%}%>
					<tr>
						<td colspan="8" align="center">
							<input type="button" value="구매"  onClick='mySubmit(1)' style="background-color: black; color: white;"/>
							<input type="button" value="삭제"  onClick='mySubmit(2)' style="background-color: black; color: white;"/> 
							<input type="button" value="취소"  onclick="window.location.href='mMypageForm.jsp'" style="background-color: black; color: white;"/> 
						</td>
					</tr>
				</table>
			</form>
	</body>
<% } %>
<jsp:include page="mFooter.jsp"/>	
</html>