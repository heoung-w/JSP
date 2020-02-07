<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
	<link href="style3.css" rel="stylesheet" type="text/css">
	<script>
		// 유효성 검사
		function check(){
			var inputs = document.inputForm;
			if(!inputs.id.value){
				alert("아이디를 입력하세요.");
				inputs.id.focus();	// 아이디입력란에 커서 깜빡이게 focus주기 
				return false;
			}
			if(!inputs.pw.value){
				alert("비밀번호를 입력하세요.");
				return false;
			}
			if(!inputs.pwCh.value){
				alert("비밀번호 확인란을 입력하세요.");
				return false;
			}
			if(inputs.pw.value != inputs.pwCh.value){
				alert("비밀번호를 동일하게 입력하세요");
				return false;
			}
			if(!inputs.name.value){
				alert("이름을 입력하세요.");
				return false;
			}
			if(!inputs.phone.value){
				alert("핸드폰번호를 입력하세요.");
				return false;
			}
			if(!inputs.email.value){
				alert("이메일을 입력하세요.");
				return false;
			}
		}
		// 아이디 중복 검사 함수
		// inputForm 매개변수에 form 전체를 받음.(this.form)
		function confirmIdPopup(inputForm){	
			// 아이디 기입 재확인.
			if(inputForm.id.value == ""){
				alert("아이디를 입력하세요.");
				return;			// 기입 안했으면 현재 메서드 종료
			}
			
			// 팝업 띄워서 아이디만 DB에 존재하는지 확인한후 돌아오게
			var url = "mConfirmId.jsp?id="+inputForm.id.value;
			
			// 화면의 띄워줄 페이지 이름과 id=값(name속성값이 id인 input 태그에 기입한 값)		
			open(url,"confirm", "toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizalbe=no, width=300, height=200");		
		}
	</script>
</head>
<jsp:include page="mHeader.jsp"/>
<%
	if(session.getAttribute("memId") != null){ %>
	<script>
		alert("로그 아웃 후 회원가입해 주세요.");
		window.location.href="mMain.jsp";
	</script>
	
<% } else {
%>
<body>
	<p class="txt" align="center">회원가입</p>
	<form action="mSignupPro.jsp" method="post" name="inputForm" onsubmit="return check()">
		<table class="table1" style="height:300px;">
			<tr>
				<td>아이디 * </td>
				<td align="left">
					<input type="text" name="id"/>
					<input type="button" value="중복검사" onclick="confirmIdPopup(this.form)" style="color: white; background-color: black;"/>
				</td>
			</tr>
			<tr>
				<td>비밀번호 * </td>
				<td colspan ="2" align = "left" style="width: 40%;"><input type="password" name="pw" /></td>
			</tr>
			<tr>
				<td>비밀번호 확인 * </td>
				<td colspan = "2" align = "left" ><input type="password" name="pwCh" /></td>
			</tr>
			<tr>
				<td>이름 * </td>
				<td colspan = "2" align = "left"><input type="text" name="name" /></td>
			</tr>
			<tr>
				<td>전화번호 * </td>
				<td colspan="2" align = "left"><input type="text" name="phone" /></td>
			</tr>
			<tr>
				<td>Email * </td>
				<td colspan = "2" align = "left"><input type="text" name="email" /></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="가입" style="color: white; background-color: black;"/>
					<input type="button" value="취소" onclick="window.location.href='mMain.jsp'" style="color: white; background-color: black;"/> 
				</td>
			</tr>
		</table>
	</form>
</body>
<% } %>
<jsp:include page="mFooter.jsp"/>	
</html>