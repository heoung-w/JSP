<%@page import="web.project.model.ReviewDAO"%>
<%@page import="web.project.model.ReviewDTO"%>
<%@page import="web.project.model.BookDTO"%>
<%@page import="web.project.model.BookDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">	
	<link href="style.css" rel="stylesheet" type="text/css" >
	<style>
		html,body{ 
			margin:0; 
			padding:0; 
			width:100%; 
			height:100%;
		}
		p.txt {
			flex: 1;
			color:white; 
			font-size:15px;
			background-color: #333;
		}
		.div{
			flex: 1;
			min-height: 100%;
			position: relative;
			padding-bottom: 0px; /* footer height */
			background-color:#d9d9d9; 
		}
		.table{
			flex: 1;
			width: 100%;
			margin-right: auto;
			margin-left: auto;
			border:5px solid #333;
			padding:5px;
			overflow:hidden;
			background-color:#d9d9d9;
		}
		.page{
			color:white; 
			font-size:12px;
			background-color: #333;
			height: 20px;
		}	
	</style>
	<script>	
		function validate(){
			console.log("val!!!!!");
			var s=document.s;
			if(!s.recontent.value){
				alert("리뷰를 입력하세요");
				return false;
			}
			if(	
				s.star1.checked==false&&
	            s.star2.checked==false&& 
	            s.star3.checked==false&& 
	            s.star4.checked==false&& 
	            s.star5.checked==false 
	            ){
		         alert("평점 선택해주세요!");
		         return false;
			}
		}
	</script>
</head>
<jsp:include page="mHeader.jsp"/>
<%
	// 로그인 상태확인
	// 세션이 없다면 로그인을 하지 않은 상태
if(session.getAttribute("memId") == null){
	String id = null, pw = null;
	Cookie[] cs = request.getCookies();
		if(cs != null){	// 쿠키가 있다면
			for(Cookie coo : cs){ // 쿠키들 반복
				if(coo.getName().equals("autoId")) id = coo.getValue();
				if(coo.getName().equals("autoPw")) pw = coo.getValue();
			}
		}
		
		if(id != null && pw != null){
			response.sendRedirect("mLoginPro.jsp");
		}

	// parameter는 문자열로만 넘어오기 때문에 숫자로 형변환 해줘야한다.
	int num = 0;
	if(request.getParameter("num") != null){
		num = Integer.parseInt(request.getParameter("num"));
	}
	// 게시판 글 목록의 몇번 페이지에서 넘어오는지 던져준 페이지 번호 값.
	String pageNum = null;
	if(request.getParameter("pageNum") != null){
		pageNum = request.getParameter("pageNum");
	} 

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	
	// DB에서 글 고유번호로 내용 꺼내와서 DTO에 담기
	BookDAO dao = BookDAO.getInstance();
	BookDTO article = dao.getArticle(num);
	
		//Review 리스트****************************************
		int pageSize = 5;//한 페이지에 보여 줄 게시글 수 
		SimpleDateFormat resdf  = new SimpleDateFormat("yyyy.MM.dd HH:mm");	
		
		String repageNum = request.getParameter("repageNum");	
		if(repageNum == null){	
			repageNum = "1";
		}
		
		// - 현재 페이지에 보여줄 review의 시작과 끝 등등 정보 세팅
		int currentPage = Integer.parseInt(repageNum);		
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;		
		int count = 0;					
		int number = 0;				
		
		// review 가져오기
		List reviewList = null;
		ReviewDAO redao = ReviewDAO.getInstance();
		
		count = redao.getReviewCount(num);	
		//System.out.println(count+"=각 책 당 등록된 리뷰 개수");
		
		//review가  하나라도 있으면 리뷰 가져오기
			 if(count>0){
					//db에서 현재 페이지에서 보여줘야 할 시작글 번호~끝글번호까지 가져오기
					reviewList=redao.getReviews(startRow, endRow, num);
				}
		// review 리스트에 뿌려줄 글번호 담기
		number = count - (currentPage-1)*pageSize;

%>
<body>
	<div class="all">
	<p align="center" class="txt">책 목록</p>
	<div class="div">
		<table class="table" style="font-size:large;">
				<tr>
					<td rowspan = "11"><img src ="/web/mSave/<%= article.getImg() %>" height = "640"/></td>
					<td></td>
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
					<td> 가  격 </td>
					<td align="center" colspan="3"><%=article.getPrice() %></td>
				</tr>
				<tr>
					<td> 출판사 </td>
					<td align="center" colspan="3"><%=article.getPublisher() %></td>
				</tr>
				<tr>
					<td> 발행일 </td>
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
				</tr>
				<tr>
					<td colspan="5">
						<button  onclick = "window.location.href='mBookListForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">북리스트로</button>
					</td>
					<td></td>
				</tr>
		</table>
	</div>
	</div>
</body>
<body>
	<%-- 등록된 리뷰가 없을때와 있을때로 구분해서 처리 --%>
	<% if(count == 0) {%>
	<div class="all" style="margin-bottom:0; background-color: black">
	<table class="table" style="font-size:large;">
		<tr>
			<td align="center">등록된 리뷰가 없습니다.</td>
		</tr>
	</table>
	</div>
	<%}else{ %>
	<div class="all" style="margin-bottom:0; background-color: black">
	<table class="table" style="font-size:large;">
		<tr>
			<td > No.   </td>
			<td > 작성자    </td>
			<td > 작성 날짜</td>
			<td > 리뷰 내용</td>
			<td > 평       점</td>   
			<td > 작성 시간</td>
		</tr> 
		<% for(int i = 0; i < reviewList.size(); i++){//등록된 리뷰 개수만큼 돌리기
			ReviewDTO review= (ReviewDTO)reviewList.get(i);
		%>
		<tr>
			<td><%=number-- %></td>
			<td><%=review.getId()%></td>
			<td><%=resdf.format(review.getBk_rereg())%></td>
			<td><%=review.getRecontent()%></td>
			<td><%=review.getStar() %></td>
			<td><%=review.getBk_rereg()%></td>
		</tr> 
		<%} %>
	</table>
	</div>
	<%}	%>
	
	<%-- 목록의 페이지번호 뷰어 설정 --%>
	<div class="all" style="margin-bottom: 0; background-color: black">
	<div align="center" class="page">
	<%	//review가 총 몇 개인지 개수 = > count
		if(count > 0){
			//review가 총 몇 페이지 나오는 지 계산
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			//review 리스트에서 보여줄 페이지 번호 개수 지정
			int pageBlock = 5;			
			//현재 위치한 페이지에서 페이지 뷰어 첫번째 숫자가 무엇인지 찾기
			int startPage = (int)(currentPage/pageBlock)*pageBlock + 1;
			//마지막에 보여지는 페이지 뷰어에 페이지 개수가 10개 미만일 경우 마지막 페이지 번호가 endPage가 되게 설정
			int endPage = startPage + pageBlock - 1;
			if(endPage > pageCount) endPage = pageCount;

			if(startPage > pageBlock){ %>
				<a href="mContentForm.jsp?repageNum=<%= startPage-pageBlock %>" > &lt; </a>
			<%}
			for(int i = startPage; i <= endPage; i++){ %>
				<a href="mContentForm.jsp?repageNum=<%=i %>&num=<%=num %>&pageNum=<%=pageNum %>" name="list"> &nbsp; <%=i %> &nbsp; </a>
			<%}
			if(endPage < pageCount){ %>
				<a href="mContentForm.jsp?repageNum=<%= startPage+pageBlock %>" > &gt; </a>
			<%}	
		}
	%>
	</div>
	</div>
</body>
<%}else{ //로그인을 하면,
		String id = "";
		if(session.getAttribute("memId") != null){
			id = (String)session.getAttribute("memId");
		}
		// parameter는 문자열로만 넘어오기 때문에 숫자로 형변환 해줘야한다.
		int num = 0;
		if(request.getParameter("num") != null){
			num = Integer.parseInt(request.getParameter("num"));
		}
		
		// 게시판 글 목록의 몇번 페이지에서 넘어오는지 던져준 페이지 번호 값.
		
		String pageNum = null;
		if(request.getParameter("pageNum") != null){
			pageNum = request.getParameter("pageNum");
		} 

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
		// DB에서 글 고유번호로 내용 꺼내와서 DTO에 담기
		BookDAO dao = BookDAO.getInstance();
		BookDTO article = dao.getArticle(num);
		
		//Review 리스트****************************************
			int pageSize = 5;//한 페이지에 보여 줄 게시글 수 
			SimpleDateFormat resdf  = new SimpleDateFormat("yyyy.MM.dd HH:mm");	
			
			
			String repageNum = request.getParameter("repageNum");	
			if(repageNum == null){	
				repageNum = "1";
			}
			
			// - 현재 페이지에 보여줄 review의 시작과 끝 등등 정보 세팅
			int currentPage = Integer.parseInt(repageNum);		
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow = currentPage * pageSize;		
			int count = 0;					
			int number = 0;				
			
			// review 가져오기
			List reviewList = null;
			ReviewDAO redao = ReviewDAO.getInstance();
			
			count = redao.getReviewCount(num);	
			//System.out.println(count+"=각 책 당 등록된 리뷰 개수");
			
			//review가  하나라도 있으면 리뷰 가져오기
				 if(count>0){
						//db에서 현재 페이지에서 보여줘야 할 시작글 번호~끝글번호까지 가져오기
						reviewList=redao.getReviews(startRow, endRow, num);
					}
			// review 리스트에 뿌려줄 글번호 담기
			number = count - (currentPage-1)*pageSize;
%>
<body>
	<div class="all">
	<p align="center" class="txt">책 목록</p>
	<div class="div">
	<table class="table" style="font-size:large;">
		<tr>
			<td rowspan = "11"><img src ="/web/mSave/<%= article.getImg() %>" height = "640"/></td>
			<td></td><td></td><td></td><td></td><td></td>
		<tr>
			<td> 작성자 </td>
			<td align="center" colspan="3"><%=article.getWriter()%> </td><td></td>
		</tr>
		<tr>
			<td> 제  목 </td>
			<td colspan="3"><%=article.getName()%></td><td></td>
		</tr>
		<tr>
			<td> 장  르 </td>
			<td align="center" colspan="3"><%=article.getGenre()%></td><td></td>
		</tr>
		<tr>
			<td> 가  격 </td>
			<td align="center" colspan="3"><%=article.getPrice() %></td><td></td>
		</tr>
		<tr>
			<td> 출판사 </td>
			<td align="center" colspan="3"><%=article.getPublisher() %></td><td></td>
		</tr>
		<tr>
			<td> 발행일 </td>
			<td align="center" colspan="3"><%=article.getRegs() %></td> <td></td>
		</tr>
		<tr>
			<td> 내  용 </td>
			<td colspan="3"><textarea rows="20" cols="70" readonly><%=article.getContent()%></textarea> </td><td></td>
		</tr>
		<tr>
			<td> 작성 시간 </td>
			<td colspan="3"> <%=sdf.format(article.getReg())%> </td><td></td>
		</tr>
		<tr>
			<td> 클릭수 </td>
			<td align="center" colspan="3"><%=article.getReadcount()%> viewed</td><td></td>
		</tr>
		<tr>
			<td colspan="5" align="left">
				<button  onclick = "window.location.href='mBookListForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">북리스트로</button>
				<button  onclick = "window.location.href='mMyAddBook.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">담기</button>
				<%if(id != null && id.equals("admin")){ %>
				<button  onclick = "window.location.href='mBookModifyForm.jsp?num=<%=article.getNum()%>'">책 수정</button>
				<button  onclick = "window.location.href='mBookDeletePro.jsp?num=<%=article.getNum()%>&name=<%=article.getName()%>&pageNum=<%=pageNum%>&endRow=<%=endRow%>'">책 삭제</button>
				<%} %>
				<% String cart = null;
				if(request.getParameter("cart") != null) cart = request.getParameter("cart");
				if(cart != null){ %>
				<button onclick = "window.location.href='mMyshopForm.jsp?num=<%=article.getNum()%>'">장바구니</button>
				<% } %>
			</td>
			
		</tr>
	</table>
	</div>
	</div>
	<%--리뷰 작성 ReviewForm--%>
	<form action="mReviewWritePro.jsp?id=<%=id%>&bk_num=<%=article.getNum()%>" method="post" name="s" onsubmit="return validate()">
		<table class="table" style="font-size:large;" >
			<tr>
				
				<td colspan="6" align="center">리뷰 작성</td>
			
			</tr>

			<tr>	
				<td colspan="6">
					<textarea cols="220" rows="5" name="recontent" placeholder="리뷰 작성"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="6">
					<input type="radio" name="star" id="star1" value="★"/>★(1점)
					<input type="radio" name="star" id="star2" value="★★"/>★★(2점)
					<input type="radio" name="star" id="star3" value="★★★"/>★★★(3점)
					<input type="radio" name="star" id="star4" value="★★★★"/>★★★★(4점)
					<input type="radio" name="star" id="star5" value="★★★★★"/>★★★★★(5점) 
				</td>
			</tr>

			<tr>
				<td colspan="6">
					<input type="submit" value="리뷰 작성" style="background-color: black; color: white;"/>
					<input type="button" value="취소" onclick="window.location.href='mBookListForm.jsp'" style="background-color: black; color: white;"/>
				</td>
			</tr>
		</table>
	</form>	
</body>
	<%-- 등록된 리뷰 뿌리기 ReviewList--%>
<body>
	<% if(count == 0) {%>
	<div class="all" style="margin-bottom:0px;">
	<table class="table" style="font-size:large;">
		<tr>
			<td align="center">등록된 리뷰가 없습니다.</td>
		</tr>
	</table>
	</div>
	<%}else{ %>
	<div class="all" style="margin-bottom:0px;">
	<table class="table" style="font-size:large;">
		<tr>
			<td > No.   </td>
			<td > 작성자    </td>
			<td > 작성 날짜</td>
			<td > 리뷰 내용</td>
			<td > 평       점</td>   
			<td > 작성 시간</td>
		</tr> 
		<% for(int i = 0; i < reviewList.size(); i++){//등록된 리뷰 개수만큼 돌리기
			ReviewDTO review= (ReviewDTO)reviewList.get(i);
		%>
		<tr>
			<td><%=number-- %></td>
			<td><%=review.getId()%></td>
			<td><%=resdf.format(review.getBk_rereg())%></td>
			<td><%=review.getRecontent()%></td>
			<td><%=review.getStar() %></td>
			<td><%=review.getBk_rereg()%></td>
		</tr> 
		<%} %>
	</table>
		<div align="center" class="page">
	<%	//review가 총 몇 개인지 개수 = > count
		if(count > 0){
			//review가 총 몇 페이지 나오는 지 계산
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			//review 리스트에서 보여줄 페이지 번호 개수 지정
			int pageBlock = 5;			
			//현재 위치한 페이지에서 페이지 뷰어 첫번째 숫자가 무엇인지 찾기
			int startPage = (int)(currentPage/pageBlock)*pageBlock + 1;
			//마지막에 보여지는 페이지 뷰어에 페이지 개수가 10개 미만일 경우 마지막 페이지 번호가 endPage가 되게 설정
			int endPage = startPage + pageBlock - 1;
			if(endPage > pageCount) endPage = pageCount;

			if(startPage > pageBlock){ %>
				<a href="mContentForm.jsp?repageNum=<%= startPage-pageBlock %>" > &lt; </a>
			<%}
			for(int i = startPage; i <= endPage; i++){ %>
				<a href="mContentForm.jsp?repageNum=<%=i %>&num=<%=num %>&pageNum=<%=pageNum %>" name="list"> &nbsp; <%=i %> &nbsp; </a>
			<%}
			if(endPage < pageCount){ %>
				<a href="mContentForm.jsp?repageNum=<%= startPage+pageBlock %>" > &gt; </a>
			<%}	
		}
	%>
	</div>
	</div>
	<%}	%>
	
	<%-- 목록의 페이지번호 뷰어 설정 --%>
<%} %>
<jsp:include page="mFooter.jsp"/>	
</body>
</html>