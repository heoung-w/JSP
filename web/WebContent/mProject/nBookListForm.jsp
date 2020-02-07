<%@page import="web.project.model.FishDAO"%>
<%@page import="web.project.model.FishDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>책 전체 리스트 페이지</title>
	<link href = "style3.css" rel = "stylesheet" type = "text/css"/>
</head>
	<jsp:include page="mHeader.jsp"/>
<%
	String id = "";
	if(session.getAttribute("memId") != null){
		id = (String)session.getAttribute("memId");
	}
	request.setCharacterEncoding("UTF-8");
	// 한 페이지에 보여줄 게시글 수와 시간 출력시 포맷 설정해주는 객체 생성
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
	
	// # 게시글 페이지 정보 담기.
	// 게시글 하단에 목록 페이지 번호 누를때마다 pageNum 파라미터 던져줄것임.
	// 여기서 받기
	
	String pageNum = null;
	if(request.getParameter("pageNum") != null){
		pageNum = request.getParameter("pageNum");
	}else{
		pageNum = "1";
	}
	
	String genre = request.getParameter("genre");
	
	// ##페이지 먼저 계산 
	// 장르 있을때 개수 가져오기
	// 장르 없을때 개수 먼저 가져오기
	// -> ((pageNum-1) * pageSize) == count ---> pageNum -= 1;
	
	//##페이지 먼저 계산
	int currentPage = Integer.parseInt(pageNum);
	int range = ((currentPage-1) * pageSize);
	int count = 0;
	int startRow = 0;
	int endRow = 0;
	
	// 게시판 글 가져오기
	List articleList = null;
	FishDAO dao = FishDAO.getInstance(); /* bookdao 타입의  dao 객체를   bookdao 안에 생성된걸 빌려다가 쓰겠다*/
	/* BookDAO dao = new BookDAO(); Book DAO 타입의 dao 생성  */
	
	
	// 장르 o
	if(genre != null){
		count = dao.getGenreArticleCount(genre);//장르 당 개수 세고	
		//System.out.println(count);
		
		if(range == count){ currentPage -= 1; }//마지막 페이지에 책 한 권만 있는 경우 =>그 책을 지웠을 때, pageNum때문에 생기는 오류 수정하기 위해서 만든 식.
		if(currentPage == 0){ currentPage = 1; }
		
		/* if(range == count) { currentPage -= 1; }
		if(currentPage == 0) { currentPage = 1; } */
		
		// 페이지 시작글 번호
		startRow = (currentPage -1) * pageSize + 1;	
		// 페이지 끝 글 번호
		endRow = currentPage * pageSize;
	
		if(count > 0){//if(range == count) ,if(currentPage == 0) 이 둘에 해당하지 않으면 여기로 바로 넘어옴. 
			articleList = dao.getGenreArticle(genre, startRow, endRow);
		}
		
	}else{	// 장르 x 
		// 전체 글 개수 가져오기
		count = dao.getArticleCount();
		
		if(range == count) { currentPage -= 1; }
		if(currentPage == 0) { currentPage = 1; }
	
		// 페이지 시작글 번호
		startRow = (currentPage -1) * pageSize + 1;	
		// 페이지 끝 글 번호
		endRow = currentPage * pageSize;
	
		if(count > 0){
			//DB에서 현재 페이지에서 보여줘야할 시작글번호 ~ 끝 글번호까지 가져오기
			articleList = dao.getArticle(startRow, endRow);
		}
	}
	
	//검색용 변수 생성 및 파라미터 받기
	String sel = request.getParameter("sel");
	String search = request.getParameter("search");
	
	//검색된 글수
	if(sel != null && search!=null){
		count= dao.getSearchArticleCount(sel,search);
		if(count>0){
			articleList = dao.getSearchArticles(startRow, endRow, sel, search);
		}
	}
	// 게시판에 뿌려줄 글 번호 담기
	int number = count - (currentPage - 1) * pageSize;
	//number가 5면,
	int a=number-1;//a는 4가 되고,
	//(number-(a--)) //처음에는 5-4=1(a--=>이렇게 --가 뒤에 있으니까=>처음 한 번 실행한 후에 --를하니까)
	//두번째에는 5-3//... 5-2// 5-1//5-0=> 12345순서대로 됨.
	
%>	

	
<body>
	<%-- 게시글 없을때 --%>
	<%
		if(count == 0) {
	%>
	<p align="center" class="txt">야 너두 작가될 수 있어</p>
	<table class="table">
		<tr>
		<td>
			<input type = "button" value = "등록" onclick = "window.location.href='nBookListInputForm.jsp'" style="color: white; background-color: black;"/>
			<input type="button" value="취소" onclick="window.location.href='mMain.jsp'" style="color: white; background-color: black;"/> 
		</td>
		</tr>
		<tr>
			<td align="center"> 책목록이 없습니다. </td>
		</tr>
	</table>
	<%-- 게시글 있을때 --%>
	<%
		}else{
	%>
	<p align="center" class="txt">야 너두 작가될 수 있어</p>
	<table class="table">
		<tr>
			<td></td><td></td><td></td><td></td><td></td><td></td><td></td>
			<td colspan="1" align = right>
				<input type = "button" value = "메인화면" onclick= "window.location.href='mMain.jsp'" style="color: white; background-color: black;"/>
				<input type = "button" value = "책등록" onclick = "window.location.href='nBookListInputForm.jsp'" style="color: white; background-color: black;"/>				
			</td>
		</tr>
		<tr>
			<td>No. </td>
			<td>책사진</td>	
			<td>제 목</td>	
			<td>저 자</td>		
			<td>장  르</td>
			<td>책 발행일</td>
			<td>조회수</td>
			<td>좋아요</td>	
		</tr>
		<%
			for(int i = 0; i < articleList.size(); i++){
				FishDTO article = (FishDTO)articleList.get(i);
		%>
			<tr>
				<% if(article.getGenre().equals("공포")){ %>
				<td style = "font-size:17px;color:black;"><%=(number-(a--))%></td>
				<td><img src="/web/mSave/<%= article.getImg()%>" width="80"></td>		
				<td style = "font-size:17px;">
					<a href="nContentForm.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>&startRow=<%=startRow%>&endRow=<%=endRow%>" style="color: black;"><%=article.getName()%></a>
				</td>
				<td style = "font-size:17px;color:black;"><%=article.getWriter()%></td>
				<td style = "font-size:17px;color:red;" ><%=article.getGenre() %></td>
				<td style = "font-size:17px;color:black;" ><%=article.getRegs() %></td>
				<td style = "font-size:17px;" ><%=article.getReadcount()%></td>
				<td style = "font-size:17px;" ><%=article.getLike() %></td>
				<% } %>
			</tr>
			<tr>
				<% if(article.getGenre().equals("로맨스")){ %>
				<td style = "font-size:17px;color:black;"><%=(number-(a--))%></td>
				<td><img src="/web/mSave/<%= article.getImg()%>" width="80"></td>		
				<td style = "font-size:17px;">
					<a href="nContentForm.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>&startRow=<%=startRow%>&endRow=<%=endRow%>" style="color: black;"><%=article.getName()%></a>
				</td>
				<td style = "font-size:17px;color:black;"><%=article.getWriter()%></td>
				<td style = "font-size:17px;color:blue;" ><%=article.getGenre() %></td>
				<td style = "font-size:17px;color:black;" ><%=article.getRegs() %></td>
				<td style = "font-size:17px;" ><%=article.getReadcount()%></td>
				<td style = "font-size:17px;" ><%=article.getLike() %></td>
				<% } %>
			</tr>
			<tr>
				<% if(article.getGenre().equals("판타지")){ %>
				<td style = "font-size:17px;color:black;"><%=(number-(a--))%></td>
				<td><img src="/web/mSave/<%= article.getImg()%>" width="80"></td>		
				<td style = "font-size:17px;color:black;">
					<a href="nContentForm.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>&startRow=<%=startRow%>&endRow=<%=endRow%>" style="color: black;"><%=article.getName()%></a>
				</td>
				<td style = "font-size:17px;"><%=article.getWriter()%></td>
				<td style = "font-size:17px;color:green;" ><%=article.getGenre() %></td>
				<td style = "font-size:17px;color:black;" ><%=article.getRegs() %></td>
				<td style = "font-size:17px;" ><%=article.getReadcount()%></td>
				<td style = "font-size:17px;" ><%=article.getLike() %></td>
				<% } %>
			</tr>		
		<%} %>
	</table>
	<%} %>
	   <div align = "center" class="bookPage">
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
               <a href = "nBookListForm.jsp?pageNum=<%=startPage-pageBlock%>"> &lt; </a>
            <%}
            
            // 페이지 번호 반복해서 뿌려주기
            for(int i = startPage; i <= endPage; i++){%>
               <a href ="nBookListForm.jsp?pageNum=<%=i %>" class="nums"> &nbsp; <%=i%> &nbsp; </a>
            <%}
            
            // startPage가 10보다 크면 > 보여주기
            if(endPage < pageCount){%>
               <a href = "nBookListForm.jsp?pageNum=<%=startPage+pageBlock%>"> &gt; </a>
            <%}           
         }
      %>
   </div>
</body>
<jsp:include page="mFooter.jsp"/>	
</html>