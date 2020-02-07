<%@page import="web.jspBoard.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	request.setCharacterEncoding("UTF-8"); // post방식 인코딩 처리 : 한글깨짐방지
	
%>
<jsp:useBean id="article" class="web.jspBoard.model.BoardDTO" />
<jsp:setProperty property="*" name="article"/>

<%
	// 페이지 번호 받기
	String pageNum = request.getParameter("pageNum");
	
	// DB에 updateArticle() 로 작성 내용 수정하기
	BoardDAO dao = new BoardDAO();
	int result = dao.updateArticle(article);
	
	// 내용 업데이트 결과(result)에 따른 페이지 처리
	if(result == 1) {	// 업데이터 정상 처리
		String uri = "list.jsp?pageNum="+pageNum;
		//String uri = "content.jsp?num="+article.getNum()+"&pageNum="+pageNum;
		response.sendRedirect(uri);
	}else{ %>
		<script>
			alert("비밀번호가 맞지 않습니다.다시 시도해주세요..");
			history.go(-1);
		</script>
<%	}%>

<body>

</body>
</html>