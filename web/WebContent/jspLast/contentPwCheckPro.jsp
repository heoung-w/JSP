<%@page import="web.jspLast.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");

	String pageNum = request.getParameter("pageNum");
	String from = request.getParameter("from");
	int num = Integer.parseInt(request.getParameter("num"));
	String pw = request.getParameter("pw");
	
	BoardDAO dao = BoardDAO.getInstance();
	boolean check = dao.isContentPwCorrect(num, pw);
	
	if(check){
		response.sendRedirect("boardContent.jsp?num="+num+"&pageNum="+pageNum+"&from="+from);
	}else{%>
		<script>
			alert("비밀번호가 맞지 않습니다. 다시 시도해주세요.");
			history.go(-1);
		</script>		
<%	}
%>

<body>

</body>
</html>