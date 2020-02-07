<%@page import="web.jspBoard.model.BoardDTO"%>
<%@page import="web.jspBoard.model.BoardDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시판</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	// 한페이지에 보여줄 게시글 수와 시간 출력시 포맷 설정해주는 객체 생성
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	
	// #게시글 페이지 정보 담기. 
	// 게시글 하단에 목록 페이지번호 누를때마다 pageNum 파라미터 던져줄것임. 
	// 여기서 받기
	String pageNum = null;
	if(request.getParameter("pageNum") != null){
		pageNum = request.getParameter("pageNum");
	}else{
		pageNum = "1";
	}
	// 처음 게시판 페이지에 접근했을때는 pageNum을 파라미터로 전달 못받으니 1로 세팅.
	//if(pageNum == null){	
		//pageNum = "1";
	//}
	
	// #현재 페이지에 보여줄 게시글의 시작과 끝 등등 정보 세팅
	// 현재 페이지
	int currentPage = Integer.parseInt(pageNum);
	// 페이지 시작글 번호
	int startRow = (currentPage - 1) * pageSize + 1;
	// 페이지 끝글 번호
	int endRow = currentPage * pageSize;
	// DB에 있는 게시글 총 개수 담을 변수, 0으로 초기화
	int count = 0;
	// 게시판에 글번호 뿌려줄 변수 (DB에 있는 글 고유 번호 X)
	int number = 0;
	
	// #게시판 글 가져오기
	List articleList = null;
	BoardDAO dao = new BoardDAO();
	// 전체 글 개수 가져오기
	count = dao.getArticleCount();
	// 글이 하나라도 있으면 글 가져오기
	if(count > 0){
		// DB에서 현재 페이지에서 보여줘야할 시작글번호~끝글번호까지 가져오기
		articleList = dao.getArticles(startRow, endRow);
	}
	
	// 게시판에 뿌려줄 글 번호 담기
	number = count - (currentPage - 1) * pageSize;

%>

<body>
	<br />
	<h1 align="center"> 게시판 </h1>

	<%-- 게시글 없을때 --%>
	<%if(count == 0) { %>
	<table>
		<tr>
			<td><button onclick="window.location='writeForm.jsp'" > 글쓰기 </button></td>
		</tr>
		<tr>
			<td align="center"> 게시글이 없습니다. </td>
		</tr>
	</table>
	<%-- 게시글 있을때 --%>
	<%}else{ %>
	<table>
		<tr>
			<td colspan="6" align="right">
				<button onclick="window.location='writeForm.jsp'" > 글쓰기 </button>
			</td>
		</tr>
		<tr>
			<td>No.</td>			
			<td>작성자</td>
			<td>제  목</td>
			<td>시  간</td>
			<td>조회수</td>
			<td>IP주소</td>
		</tr>
		<%for(int i = 0; i < articleList.size(); i++){
			BoardDTO article = (BoardDTO)articleList.get(i);  
		%>
			<tr>
				<td><%=number--%></td>
				<td><a href="mailto:<%=article.getEmail()%>"><%=article.getWriter()%></a></td>
				<td align="center">
					<%	// 답글은 제목 들여쓰기
						int wid = 0;
						if(article.getRe_level() > 0){
							wid = 8*(article.getRe_level());  %>
					<img src="img/tabImg.PNG" width="<%=wid%>" /> <%--배경색으로 들여쓰기 효과 --%>
					<img src="img/replyImg.png" width="10" />		
					<%	}
					%>
					<a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>"><%=article.getSubject()%></a>
				</td>
				<td><%=sdf.format(article.getReg())%></td>
				<td><%=article.getReadcount()%></td>
				<td><%=article.getIp()%></td>
			</tr>
		<%} %>
		
	</table>
	<%} %>
	   <div align = "center">
      <%
         if(count >0){
            // 10페이지씩 끊어서 목록 보여주게 만들기
            // 총 몇 페이지 나오는지 계산            0으로 떨어지면 0 아니면 1으로 더한다.
            //  pageSize로 나눠서 남는 글이 하나라도 있으면 페이지에 1더하기
            int pageCount = count / pageSize +(count % pageSize ==0?0:1);
            // 보여줄 페이지 번호의 개수 지정 : 페이지번호도 10개씩 끊어서 보여주겠다.
            int pageBlock = 10;
            // 현재 위치한 페이지에서 페이지 뷰어 첫번째 숫자가 무엇인지 찾기
            int startPage = (int)(currentPage / pageBlock)* pageBlock +1;
            
            // 마지막에 보여지는 페이지뷰어에 페이지 개수가 10미만일 경우 마지막 페이지 번호가 endPage가 되도록 설정
            int endPage = startPage + pageBlock -1;
            
            if(endPage > pageCount) endPage = pageCount;
            
            // startPage가 10보다 크면 < 보여주기
            if(startPage > pageBlock){%>
               <a href = "list.jsp?pageNum=<%=startPage-pageBlock%>"> &lt; </a>
            <%}
            
            // 페이지 번호 반복해서 뿌려주기
            for(int i = startPage; i <= endPage; i++){%>
               <a href ="list.jsp?pageNum=<%=i %>" class="nums"> &nbsp; <%=i%> &nbsp; </a>
            <%}
            
            // startPage가 10보다 크면 > 보여주기
            if(endPage < pageBlock){%>
               <a href = "list.jsp?pageNum=<%=startPage+pageBlock%>"> &gt; </a>
            <%}
            
               
         }
      %>
   </div>

</body>
</html>