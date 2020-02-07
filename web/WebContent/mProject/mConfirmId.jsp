
<%@page import="web.project.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>ID 중복확인</title>
	<link href="style.css" rel="stylesheet" type="text/css">
	<style>
		p.txt {
			color:white; 
			font-size:15px;
			background-color: #333;
		}
		.table{
			width: 100%;
			margin-right: auto;
			margin-left: auto;
			margin-bottom:0;
			border:5px solid #333;
			padding:5px;
			overflow:hidden;
			background-color: #d9d9d9;
		}		
		.bookPage{
			color:white; 
			font-size:15px;
			background-color: #333;
		}
	</style>
</head>
<%-- 팝업으로 열릴 창 만들기 --%>

<%
	
		request.setCharacterEncoding("UTF-8");
	
		// 주소뒤에 붙혀온 파라미터 받기
		String id = request.getParameter("id");
		// DB 연결해서 입력받아 넘어온 id가 DB에 이미 존재하는지 확인
		MemberDAO dao = new MemberDAO();
		boolean check = dao.mConfirmId(id);
		// check == true : DB에 이미 id가 존재한다. 
		// check == false : DB에 존재하지 않는 id (새로 가입하는 사용자가 사용가능한 id)
		if(check) {	// id 이미 존재함 ==> 사용중인 id
%>
<body>
	<table class="table" style="margin-bottom:0;">
		<tr>
			<td><%=id %>는 이미 사용중인 아이디입니다.  </td>
		</tr>
	</table> <br /><br />
	<form action="mConfirmId.jsp" method="post">
		<%-- 다시 id 입력해서 중복되는지 조회할 수 있는 입력 form 만들기 --%>
		<table class="table" style="margin-bottom:0;">
			<tr>
				<td>다른 아이디를 선택하세요. <br />
					<input type="text" name="id" />
					<input type="submit" value="ID중복확인" />
				</td>
			</tr>
		</table>
	</form>
</body>

<%		}else{ 	// id 존재하지 않음. ==> 사용가능한 id %>
<body>
	<table class="table" style="margin-bottom:0;">
		<tr>
			<td>입력하신 <%=id %>는 사용가능한 아이디입니다. <br />
				<input type="button" value="닫기" onclick="setId()"/>
			</td>
		</tr>
	</table>
</body>
	<script>
		function setId() {
			// signupForm페이지의 id 기입 input태그에 위에서 검사한 id값 적용 시키기.
			opener.document.inputForm.id.value="<%=id%>";
			
			// 팝업창 화면 닫기
			self.close();
		}
	</script>

<%
}%>
</html>