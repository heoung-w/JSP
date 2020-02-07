<%@page import="web.jspLast.model.MemberDTO"%>
<%@page import="web.jspLast.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 리스트</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	// # 관리자 전용 회원리스트 페이지 
	
	request.setCharacterEncoding("UTF-8");

	if(session.getAttribute("memId") == null){ %>
		<script>
			alert("관리자 페이지. 로그인하세요.");
			window.location="loginForm.jsp";
		</script>	
<%	}else{
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	
	// # boardList 페이지 활용
	int pageSize = 10;
	String pageNum = request.getParameter("pageNum");	
	if(pageNum == null){	
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);		
	int startRow = (currentPage - 1) * pageSize + 1;	
	int endRow = currentPage * pageSize;			
	int count = 0;						
	int number = 0;						
	
	String id = (String)session.getAttribute("memId");
	List memberList = null;
	MemberDAO dao = MemberDAO.getInstance();
	
	if(id.equals("admin")) { 
		String selector = request.getParameter("selector");
		String search = request.getParameter("search");
		if(selector != null && search != null){	
			// # 회원수 가져오기
			count = dao.getSearchMemberCount(selector, search);
			if(count > 0) {
				memberList = dao.getSearchMemberList(startRow, endRow, selector, search);
			}
		}else{	// 처음방문이나, 아래 form에서 선택없을 경우
			count = dao.getMemberCount();
			if(count > 0){
				memberList = dao.getMemberList(startRow, endRow);
			}
		}
%>
<body>
	<br />
	<h1 align="center"> 회원 리스트 </h1>
	<table>
		<tr>
			<td colspan="6">
				<form action="memberList.jsp" method="post">
					<select name="selector">
						<option value="id">ID</option>
						<option value="name">Name</option>
					</select>
					<input type="text" name="search" />
					<input type="submit" value="검색" />
				</form>
			</td>
		</tr>
		<tr>
			<td>id</td>
			<td>name</td>
			<td>birth</td>
			<td>email</td>
			<td>photo</td>
			<td>reg</td>
		</tr>
		<%for(int i = 0; i < memberList.size(); i++){
			MemberDTO member = (MemberDTO)memberList.get(i);%>
		<tr>
			<td><%=member.getId()%></td>
			<td><%=member.getName()%></td>
			<td><%=member.getBirth()%></td>
			<td><a href="mailto:<%=member.getEmail()%>"><%=member.getEmail()%></a></td>
			<td>
				<%if(member.getPhoto() == null){ %>
					<img src="img/default_img.jpg"  width="100" /> <br />
				<%}else{ %>
					<img src="/web/save/<%=member.getPhoto()%>"  width="100" /> <br />
				<%} %>
			</td>
			<td><%=sdf.format(member.getReg()) %></td>
		</tr>
		<%} %>
	</table>
	
	<%-- 목록의 페이지번호 뷰어 설정 --%>
	<div align="center">
	<br />
	<%
		if(count > 0){
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			int pageBlock = 10;			
			int startPage = (int)(currentPage/pageBlock)*pageBlock + 1;
			int endPage = startPage + pageBlock - 1;
			if(endPage > pageCount) endPage = pageCount;
			
			if(startPage > pageBlock){ %>
				<a href="memberList.jsp?pageNum=<%= startPage-pageBlock %>" > &lt; </a>
			<%}
			for(int i = startPage; i <= endPage; i++){ %>
				<a href="memberList.jsp?pageNum=<%=i %>" name="list"> &nbsp; <%=i %> &nbsp; </a>
			<%}
			if(endPage < pageCount){ %>
				<a href="memberList.jsp?pageNum=<%= startPage+pageBlock %>" > &rt; </a>
			<%}
		}
	%>
	<%-- # 메인으로 가는 버튼 추가 --%>
	<br /><br />
	<button onclick="window.location='main.jsp'"> 메인으로 </button>
	</div>
	
</body>
<%	}else{%>
		<script>
			alert("관리자만 이용 가능합니다.");
			window.location="main.jsp";
		</script>
<%	}
}%>
</html>