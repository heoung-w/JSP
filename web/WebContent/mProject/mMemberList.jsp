<%@page import="web.project.model.MemberDTO"%>
<%@page import="web.project.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 리스트</title>
	<link href="style3.css" rel="stylesheet" type="text/css">
</head>
<jsp:include page="mHeader.jsp"/>
<%
	// # 관리자 전용 회원리스트 페이지 
	
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("memId");
	String admin = (String)session.getAttribute("admin");

	if(session.getAttribute("admin")=="admin" ){ %>
		<script>
			alert("관리자 페이지. ");
			window.location="mLoginForm.jsp";
		</script>	
<%	}else{//admin이면
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	
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
	
	//String id = (String)session.getAttribute("memId");
	List memberList = null;
	MemberDAO dao = new MemberDAO();
	
	if(id.equals("admin")){ 
			count = dao.getMemberCount();
			//System.out.println(count+"회원 총 명수");
			if(count > 0){
				memberList = dao.getMemberList(startRow, endRow);
				//System.out.println(memberList+"회원 리스트");
			}
		
%>
<body>
	<p class="txt" align="center"> 회원 리스트 </p>
	<div class="div">
	<form action="mMemberDeleteByAdmin.jsp" method="post">
		<table class="table1" style="width: 80%">
			<tr>
				<td>  </td>
				<td>id</td>
				<td>name</td>
				<td>Phone</td>
				<td>email</td>
				<td>money</td>
				<td>cart</td>
				<td>reg</td>
			</tr>
			<%for(int i = 0; i < memberList.size(); i++){
				MemberDTO member = (MemberDTO)memberList.get(i);%>
			<tr>
				<td>
					<input type="checkbox" name="memberCheck" value="<%=member.getId()%>"/>
				</td>
				<td><%=member.getId()%></td>
				<td><%=member.getName()%></td>
				<td><%=member.getPhone()%></td>
				<td><%=member.getEmail()%></td>
				<td><%=member.getMoney() %></td>
				<td><%=member.getCart() %></td>
				<td><%=member.getReg() %></td>
			</tr>
			<%} %>
			<tr>
				<td colspan="8" align="center">
					<input type="submit" value="탈퇴" style="color: white; background-color: black;">
					<input type="button" onclick="history.go(-1)" value="메인으로" style="color: white; background-color: black;">
				</td>
			</tr>
		</table>
	</form>
	</div>
	<%-- 목록의 페이지번호 뷰어 설정 --%>
	<div class="bookPage" align="center">
	<%
		if(count > 0){
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			int pageBlock = 10;			
			int startPage = (int)(currentPage/pageBlock)*pageBlock + 1;
			int endPage = startPage + pageBlock - 1;
			if(endPage > pageCount) endPage = pageCount;
			
			if(startPage > pageBlock){ %>
				<a href="mMemberList.jsp?pageNum=<%= startPage-pageBlock %>" > &lt; </a>
			<%}
			for(int i = startPage; i <= endPage; i++){ %>
				<a href="mMemberList.jsp?pageNum=<%=i %>" name="list"> &nbsp; <%=i %> &nbsp; </a>
			<%}
			if(endPage < pageCount){ %>
				<a href="mMemberList.jsp?pageNum=<%= startPage+pageBlock %>" > &rt; </a>
			<%}
		}
	%>
	</div>
</body>
<%	}else{%>
		<script>
			alert("관리자만 이용 가능합니다.");
			window.location="mMain.jsp";
		</script>
<%	}
}%>
<jsp:include page="mFooter.jsp"/>	
</html>