<%@page import="web.project.model.ReviewDTO"%>
<%@page import="web.project.model.ReviewDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>mMyReviewForm</title>
	<link href="style3.css" rel="stylesheet" type="text/css" >
	<style>
		.table{
			width: 800%;
			margin-right: auto;
			margin-left: auto;
			margin-bottom:0;
			border:0px solid #333;
			padding:0px;
			overflow:hidden;
			background-color: #d9d9d9;
		}		
	</style>
</head>
	<jsp:include page="mHeader.jsp"/>
<%
	// # 로그인 체크 
	if(session.getAttribute("memId") == null) { %>
		<script>
			alert("로그인 후 이용 가능");
			window.location="loginForm.jsp?pageNum=1&from=mMyReviewForm";
		</script>	
<%	}else{// # 세션X 쿠키 있는건 알아서 처리하기.

	String id = (String)session.getAttribute("memId");

	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");	
	
	
	String pageNum = request.getParameter("pageNum");	
	if(pageNum == null){	
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);		
	int startRow = (currentPage - 1) * pageSize + 1;	
	int endRow = currentPage * pageSize;			
	int count = 0;					
	int number = 0;
	
	List reviewList = null; 

	ReviewDAO dao = ReviewDAO.getInstance();
	count = dao.getMyReviewCount(id);		
	
	if(count > 0) {							
		reviewList = dao.getMyReviews(startRow, endRow, id);	
	}
	number = count - (currentPage-1)*pageSize;
%>
<body>
	<br />
	<p class="txt" align="center"> 내가 쓴 리뷰 목록 </p>
	<% if(count == 0) {%>
			<table class="table">
				<tr>
					<td align="center">등록된 리뷰가 없습니다.</td>
				</tr>
				<tr>
					<td>
						<input type="button" value="책목록으로" onclick="window.location.href='mBookListForm.jsp'">
						<input type="button" value="취소" onclick="window.location.href='mMypageForm.jsp'">
					</td>
				</tr>
			</table>
	<%}else{ %>
			<form action="mReviewDeletePro.jsp" method="post">
					<table class="table">
						<tr>
							<td>         </td>
							<td > No.   </td>
							<td > 작성자    </td>
							<td > 리뷰 내용</td>
							<td > 평       점</td>   
							<td > 작성 시간</td>
						</tr> 
						<%-- review 반복해서 뿌려주기 --%>
						<% for(int i = 0; i < reviewList.size(); i++){//등록된 리뷰 개수만큼 돌리기
							ReviewDTO review= (ReviewDTO)reviewList.get(i);
						%>
						<tr>
							<td>
								<input type="checkbox" name="reviewCheck" value="<%=review.getNum()%>"/>
							</td>
							<td><%=number-- %></td>
							<td><%=review.getId()%></td>
							<td><%=review.getRecontent()%></td>
							<td><%=review.getStar() %></td>
							<td><%=review.getBk_rereg()%></td>
							<td>
								<input type="button" value="수정" onclick="window.location.href='mReviewModifyForm.jsp?num=<%=review.getNum()%>&id=<%=review.getId()%>'" style="color: white; background-color: black;">
							</td>
						</tr>
						<%} %>
						<tr>
							<td>         </td><td>         </td>		<td>         </td><td>         </td>			
							<td>
								<input type="submit" value="삭제" style="color: white; background-color: black;">
								<input type="button" value="마이페이지" onclick="window.location.href='mMypageForm.jsp'"style="color: white; background-color: black;">
							</td>
						</tr>
					</table>
			</form>
	<%}	%>
	<%-- 목록의 페이지번호 뷰어 설정 --%>
	<div align="center" class="bookPage">
	<%	
			if(count > 0){
					//review가 총 몇 페이지 나오는 지 계산
					int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
					//review 리스트에서 보여줄 페이지 번호 개수 지정
					int pageBlock = 10;			
					//현재 위치한 페이지에서 페이지 뷰어 첫번째 숫자가 무엇인지 찾기
					int startPage = (int)(currentPage/pageBlock)*pageBlock + 1;
					//마지막에 보여지는 페이지 뷰어에 페이지 개수가 10개 미만일 경우 마지막 페이지 번호가 endPage가 되게 설정
					int endPage = startPage + pageBlock - 1;
					if(endPage > pageCount) endPage = pageCount;
		
					if(startPage > pageBlock){ %>
						<a href="reviewList.jsp?pageNum=<%= startPage-pageBlock %>" > &lt; </a>
					<%}
					for(int i = startPage; i <= endPage; i++){ %>
						<a href="reviewList.jsp?pageNum=<%=i %>" name="list"> &nbsp; <%=i %> &nbsp; </a>
					<%}
					if(endPage < pageCount){ %>
						<a href="reviewList.jsp?pageNum=<%= startPage+pageBlock %>" > &gt; </a>
					<%}
			}
	}%>
	</div>
</body>
<jsp:include page="mFooter.jsp"/>	
</html>