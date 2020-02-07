<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
	<link href="style.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		// 미기입 유효성 검사
		function checkIt() {
			var inputs = eval("document.inputForm");
			if(!inputs.id.value){
				alert("아이디를 입력하세요.");
				return false;
			}
			if(!inputs.pw.value){
				alert("비밀번호를 입력하세요.");
				return false;
			}
			if(!inputs.pwCh.value){
				alert("비밀번호확인란을 입력하세요.");
				return false;
			}
			if(inputs.pw.value != inputs.pwCh.value){
				alert("비밀번호를 동일하게 입력하세요.");
				return false;
			}
			if(!inputs.name.value){
				alert("이름을 입력하세요.");
				return false;
			}
		}

		function openConfirmId(inputForm) {		
			if(inputForm.id.value == ""){
				alert("아이디를 입력하세요");
				return;
			}

			var url = "confirmId.jsp?id="+inputForm.id.value;		
					
			open(url, "confirm", "toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=300, height=200");
		}
		
		
	</script>
</head>
<%
	// # 로그인 상태에서 주소로 접근하면 main으로 넘기기
	if(session.getAttribute("memId") != null) {
		response.sendRedirect("main.jsp");
	}
	// # 세션x, 쿠키 있는 경우 
	if(session.getAttribute("memId") == null){
		String id = null, pw = null, auto = null;
		Cookie [] cs = request.getCookies();
		if(cs != null){		// 쿠키가 있다면 데이터 꺼내와 담기
			for(Cookie coo : cs){
				if(coo.getName().equals("autoId")) id = coo.getValue();
				if(coo.getName().equals("autoPw")) pw = coo.getValue();
				if(coo.getName().equals("autoCh")) auto = coo.getValue();
			}
		}
		// 세션은 없지만 쿠키가 있어서 값을 꺼내담아 값이 있을경우 바로 loginPro로 넘어감. 
		if(auto != null && id != null && pw != null){
			response.sendRedirect("loginPro.jsp");
		}
	}
%>
<body>
	<br />
	<h1 align="center"> 회원가입 </h1>
	<form action="signupPro.jsp" method="post" enctype="multipart/form-data" name="inputForm" onsubmit="return checkIt()">	
		<table>
			<tr>
				<td>아이디*</td>
				<td><input type="text" name="id" /></td>
			</tr>
			<tr>
				<td></td>		
				<td><input type="button" value="아이디 중복 확인" onclick="openConfirmId(this.form)"></td>
			</tr>
			<tr>
				<td>비밀번호*</td>
				<td><input type="password" name="pw" /></td>
			</tr>
			<tr>
				<td>비밀번호 확인*</td>
				<td><input type="password" name="pwCh" /></td>
			</tr>
			<tr>
				<td>이름*</td>
				<td><input type="text" name="name"  /></td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td><input type="text" name="birth" maxlength="8" /></td>
			</tr>
			<tr>
				<td>e-mail</td>
				<td><input type="text" name="email"  /></td>
			</tr>
			<tr>
				<td>photo</td>
				<td><input type="file" name="photo"  /></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="가입"/>
					<input type="reset" name="reset" value="재입력" />
					<input type="button" value="취소" onclick="window.location='main.jsp'"/>
				</td>
			</tr>
		</table>
	</form>

</body>
</html>