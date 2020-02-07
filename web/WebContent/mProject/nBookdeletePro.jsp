<%@page import="web.project.model.FishDAO"%>
<%@page import="web.project.model.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="web.project.model.MemberDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>deletePro</title>
</head>
<%	
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("memId");
	String admin = (String)session.getAttribute("admin");
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	//int startRow = Integer.parseInt(request.getParameter("startRow"));	
	int endRow = Integer.parseInt(request.getParameter("endRow"));	
	
	int bk_num = 0;
	if(request.getParameter("num") != null){
		bk_num = Integer.parseInt(request.getParameter("num"));
	}
		
		int result = 0;
				
		FishDAO dao = FishDAO.getInstance();
						
		String num = request.getParameter("num");
		
		dao.deleteBook(bk_num); // deleteBook 메서드 1  -> 가서 질문
		
	if(id.equals("admin")){%>
		<body>
			<script>
				alert("야너도작가될수있어 삭제완료");
				window.location.href="nBookListForm.jsp?pageNum=<%=pageNum%>";
			</script>
		</body>	
	<%}else{ %>
		<script>
				alert("관리자만 이용 가능합니다.");
				window.location.href="mBookListForm.jsp?pageNum=<%=pageNum%>";
		</script>
	<%} %>	

</html>




