<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 작성</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	// 글번호, 그룹, 정렬순서, 답글 레벨 선언 -> 초기화
	// DB에 들어가야할 데이터들 초기화해서 변수에 담아 데이터 보내기
	int num = 0, ref = 1, re_step = 0, re_level = 0;
	// num(새글작성0, 답글 1이상), ref는 기본그룹 1
	
	// 답글일때 처리 : num, ref,re_step,re_level
	if(request.getParameter("num") != null){	// 답글일경우에만 num 파라미터 들고옴.
		// 답글버튼 눌러서 함께 넘어온 정보 위 초기값 무시하고 덮어쓰기
		num = Integer.parseInt(request.getParameter("num"));
		ref = Integer.parseInt(request.getParameter("ref"));
		re_step = Integer.parseInt(request.getParameter("re_step"));
		re_level = Integer.parseInt(request.getParameter("re_level"));
	}
	
%>

<body>
	<br />
	<h1 align="center"> 글 작성 </h1>
	<form action="writePro.jsp" method="post">
		<%-- 숨겨서 글 속성에 관련된 데이터 전송 --%>
		<input type="hidden" name="num" value="<%=num%>" />
		<input type="hidden" name="ref" value="<%=ref%>" />
		<input type="hidden" name="re_step" value="<%=re_step%>" />
		<input type="hidden" name="re_level" value="<%=re_level%>" />
		<table>
			<tr>
				<td> 작성자 </td>
				<td align="left"> <input type="text" name="writer" /> </td>
			</tr>
			<tr>
				<td> 제   목 </td>
				<td align="left"> 
					<%if(request.getParameter("num") == null){ %>
					<input type="text" name="subject" /> 
					<%}else{ %>
					<input type="text" name="subject" value="[답글]"/>
					<%} %> 
				</td>
			</tr>
			<tr>
				<td> e-mail </td>
				<td align="left"> <input type="text" name="email" /> </td>
			</tr>
			<tr>
				<td> 내   용 </td>
				<td> <textarea rows="20" cols="70" name="content"></textarea> </td>
			</tr>
			<tr>
				<td> 비밀번호 </td>
				<td align="left"> <input type="password" name="pw" /> </td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="저장" />
					<input type="reset" value="재작성" />
					<input type="button" value="리스트보기" onclick="window.location='list.jsp'" />
				</td>
			</tr>
		</table>
	</form>
	
	
</body>
</html>