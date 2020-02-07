<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href = "style3.css" rel = "stylesheet" type = "text/css"/>
	</head>
	<script>
		function check(){
			var inputs = document.inputsForm;
			if(!inputs.name.value){
				alert("책 제목을 입력해 주세요");
				inputs.name.focus;
				return false;
			}
			if(!inputs.img.value){
				alert("이미지를 선택해주세요.");
				return false;
			}
			if(!inputs.price.value){
				alert("책가격을 입력해주세요.")
				return false;
			}
			if(!inputs.genre.value){
				alert("장르를 입력해주세요.");
				return false;
			}
			if(!inputs.writer.value){
				alert("저자를 입력해주세요.");
				return false;
			}
			if(!inputs.publisher.value){
				alert("출판사를 입력해주세요.");
				return false;
			}
			if(!inputs.content.value){
				alert("줄거리를 입력해주세요.");
				return false;
			}
			if(!inputs.date.value){
				alert("발행일을 선택해주세요.");
				return false;
			}
		}
	</script>
<jsp:include page="mHeader.jsp"/>
<%
String id = (String)session.getAttribute("memId");
if(session.getAttribute("memId")==null){ %>
	<script>
		alert("로그인후 이용해주세요!!");
		window.location.href="mLoginForm.jsp";
	</script>
<%} else if(id != null && !id.equals("admin")){ %>
	<script>
		alert("관리자만 이용가능합니다.!!");
		window.location.href="mMain.jsp";
	</script>
<% }else if(id.equals("admin")){ 
%>
<body>
	<p class="txt" align="center">책 등록</p>
	<div class="div">
	<form action="mBookListInputPro.jsp" enctype="multipart/form-data" method="post" name="inputsForm" onsubmit="return check();">
		<table class="table1" >
			<tr>
				<td align="center">책 제목 * </td>
				<td align = "center"><input type="text" name="name" style = "width:300px" placeholder = "제목 입력."/></td>
			</tr>
			<tr>
				<td align="center">이미지 * </td>
				<td align="center"><input type="file" name = "img" style = "width:300px" /></td>
			</tr>
			<tr>
				<td align="center">가격 * </td>
				<td><input type="text" name="price" maxlength="6" style = "width:300px" placeholder = "가격 입력."/></td>
			</tr>
			<tr>
				<td align="center">장르 * </td>
					<td>
						<select name="select" style="color:black; width:300px">
							<option value="판타지" style = "font-size:20px; color:blue;">판타지</h1></option>
							<option value="공포" style = "font-size:20px; color:red;">공포</option>
							<option value="로맨스" style = "font-size:20px; color:green;">로맨스</option>
						</select>
					</td>
			</tr>
			<tr>
				<td align="center">저자 * </td>
				<td><input type="text" name="writer" style = "width:300px" placeholder = "저자 입력."/></td>
			</tr>
			<tr align="center">
				<td>출판사 * </td>
				<td><input type="text" name="publisher" style = "width:300px" placeholder = "출판사 입력." /></td>
			</tr>
			<tr align="center">
				<td>줄거리 * </td>
				<td><textarea rows = "20" cols = "70" name="content" style = "width:400px" placeholder = "줄거리 입력."></textarea></td>
			</tr>
			<tr align="center">
				<td>책 발행일 * </td>
				<td><input type="date" name="date" /></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="등록" style="color: white; background-color: black;"/>
					<input type="button" value="취소" onclick="window.location.href='mBookListForm.jsp'" style="color: white; background-color: black;"/> 
				</td>
			</tr>
		</table>
	</form>
	</div>
</body>
<% } %>
<jsp:include page="mFooter.jsp"/>	
</html>