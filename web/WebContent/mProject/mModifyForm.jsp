<%@page import="web.project.model.MemberDTO"%>
<%@page import="web.project.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원정보 수정 페이지</title>	
	<link href = "style3.css" rel="stylesheet" type = "text/css"/>
	<script>
			/* eval()
			eval()은 문자열을 코드로 인식하게 하는 함수입니다. */
		//!A.equals.B
		function check(){ 
			var inputs = eval("document.inputsForm"); // 쌍 따옴표 안에 있는 얘들을 기능이 있는 코드라고 인식 하고 처리 해 주는 것
			//var inputs = document.getElementsByName("inputsForm"); // 메서드로 가져오기
			if(!inputs.pw.value){
				alert("비밀번호를 입력하세요.");
				return false;
			}
			if(!inputs.pwCh.value){
				alert("비밀번호 확인란을 입력하세요.");
				return false;
			}
			if(inputs.pw.value!=inputs.pwCh.value){
				alert("비밀번호를 동일하게 입력하세요");
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
	</script>
</head>
<jsp:include page="mHeader.jsp"/>
<%
	if(session.getAttribute("memId") == null) { %>
		<script>
			alert("로그인 해주세요!");
			window.location.href="mLoginForm.jsp";
		</script>
		
<%	}else{	// 로그인 된 상태

		// 로그인 된 상태에서 실행 == session에 memId 존재
		// DB에 접속해서 회원의 정보를 모두 긁어와 화면에 뿌려주기
		// session에 저장된 사용자의 id 꺼내기
		String id = (String)session.getAttribute("memId");
		MemberDAO dao = new MemberDAO();
		MemberDTO member = dao.getMember(id);
%>
<body>
	<p class="txt" align="center"> 회원정보 수정 </p>
	<div class="div">
		<form action="mModifyPro.jsp" method="post" name = "inputsForm" onsubmit="return check()">
		<table class="table1" style="width: 40%;">
			<tr>
				<td>아이디 * </td>
				<td><%=member.getId() %></td>
			</tr>
			<tr>
				<td>비밀번호 * </td>
				<td><input type="password" name="pw" value="<%=member.getPw()%>"/></td>
			</tr>
			<tr>
				<td>비밀번호 확인 * </td>
				<td><input type="password" name="pwCh" /></td>
			</tr>
			<tr>
				<td>이름 * </td>
				<td><%=member.getName() %></td>
			</tr>
			<tr>
				<td>핸드폰 번호 *</td>
				<td>
					<input type="text" name="phone" value="<%=member.getPhone()%>"/>
				</td>
			</tr>
			<tr>
				<td>Email </td>
				<td>
					<input type="text" name="email" value="<%=member.getEmail()%>"/>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="수정완료" style="background-color: black; color: white;"/>
					<input type="button" value= "회원탈퇴" onclick="window.location.href='mDeleteForm.jsp'" style="background-color: black; color: white;"/>
					<input type="button" value="취소" onclick="window.location.href='mMypageForm.jsp'" style="background-color: black; color: white;"/> 
				</td>
			</tr>
		</table>
		</form>
	</div>
</body>
<% } %>
<jsp:include page="mFooter.jsp"/>	
</html>