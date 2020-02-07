
<%@page import="web.project.model.MemberDAO"%>
<%@page import="web.project.model.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("utf-8"); 
  
    String num = null;
	if(request.getParameter("num") != null){
		num = request.getParameter("num");
	} 
	
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
    
	int number = 0;
	if(request.getParameter("num") != null){
		number = Integer.parseInt(request.getParameter("num"));
	}
   
    String name = null;
	if(request.getParameter("name") != null){
		name = request.getParameter("name");
	} 
   
    BookDAO dao = BookDAO.getInstance();
    dao.deleteBookList(number);
   
    MemberDAO article = new MemberDAO();
    article.deleteMemberCart(num);
    article.deleteMemberBuyList(num);
   
    String id = (String)session.getAttribute("memId");
	String admin = (String)session.getAttribute("admin");
   
   if(id.equals("admin")){
%>   
<body>
   <script>
      alert("<%=name %>이 삭제되었습니다");
      window.location.href="mBookListForm.jsp?pageNum=<%=pageNum%>";
   </script>
</body>
<%}else{ %>
		<script>
				alert("관리자만 이용 가능합니다.");
				window.location="mBookListForm.jsp";
		</script>
<% } %>
</html> 