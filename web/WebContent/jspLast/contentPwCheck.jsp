<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 비밀번호 확인</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	// # 파라미터들 받기
	String pageNum = request.getParameter("pageNum");
	String from = request.getParameter("from");
	int num = Integer.parseInt(request.getParameter("num"));
	
	String id = "";
	// # 관리자 확인
	if(session.getAttribute("memId") != null){
		id = (String)session.getAttribute("memId");
		if(id.equals("admin")){ 
			response.sendRedirect("boardContent.jsp?num="+num+"&pageNum="+pageNum+"&from="+from);
		}
	}
	
	// # 로그인 상태 체크
	if(session.getAttribute("memId") == null){ %>
		<script>
			alert("로그인 후 사용해주세요.");
			window.location = "loginForm.jsp?from="+from+"&pageNum="+pageNum;
		</script>
<%	}else{ %>
	
<body>
	<br />
	<p align="center"> 비밀번호 </p>
	<form action="contentPwCheckPro.jsp?pageNum=<%=pageNum%>&from=<%=from%>" method="post">
		<table>
			<tr>
				<td align="center"> 비밀번호를 입력해주세요. </td>
			</tr>
			<tr>
				<td align="center"> 
					<input type="password" name="pw" />	
					<input type="hidden" name="num" value="<%=num%>" /> 
				</td>
			</tr>
			<tr>
				<td align="center">
					<input type="submit" value="확인" />
					<input type="button" value="게시판으로" onclick="window.location='boardList.jsp?pageNum=<%=pageNum%>'" />
				</td>
			</tr>
		</table>
	</form>
</body>
<%	}
%>
</html>