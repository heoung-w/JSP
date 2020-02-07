<%@page import="web.jspLast.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title> delete pro</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	request.setCharacterEncoding("UTF-8");

	//# 로그인 상태 확인하고 페이지 처리
	if(session.getAttribute("memId") == null) { %>
		<script>
			alert("로그인 후 이용 가능");
			window.location="loginForm.jsp?pageNum=1&from=boardList";
		</script>	
<%	}else{// # 세션X 쿠키 있는건 알아서 처리하기


	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String pw = request.getParameter("pw");

	BoardDAO dao = BoardDAO.getInstance();
	
	
	String id = (String)session.getAttribute("memId");
	if(id.equals("admin")){
		dao.deleteArticleByAdmin(num); %>
		<script>
			alert("삭제 완료!");
			window.location = "boardList?pageNum="+pageNum;
		</script>
<%	}else{
	
		int check = dao.deleteArticle(num, pw);
		if(check == 1){
			response.sendRedirect("boardList.jsp?pageNum="+pageNum);
		}else{ %>
			<script>
				alert("비밀번호 오류! 다시 시도해보세요.");
				history.go(-1);
			</script>
<%		}
	}
}%>

<body>

</body>
</html>