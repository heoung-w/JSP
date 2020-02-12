<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>ID 중복확인</title>
	<link href="/web/memberViewImg/style.css" rel="stylesheet" type="text/css" >
	
</head>
<%-- 팝업으로 열릴 창 만들기 --%>
<c:if test="${check ==true }">
<body>
	<table>
		<tr>
			<td>${trialid }는 이미 사용중인 아이디입니다.  </td>
		</tr>
	</table> <br /><br />
	<form action="/web/member/confirmId.jsp" method="post">
		<%-- 다시 id 입력해서 중복되는지 조회할 수 있는 입력 form 만들기 --%>
		<table>
			<tr>
				<td>다른 아이디를 선택하세요. <br />
					<input type="text" name="id" />
					<input type="submit" value="ID중복확인" />
				</td>
			</tr>
		</table>
	</form>
</body>
</c:if>
<c:if test="${check ==false }">
<body>
	<table>
		<tr>
			<td>입력하신 ${trialid} 는 사용가능한 아이디입니다. <br />
				<input type="button" value="닫기" onclick="setId()"/>
			</td>
		</tr>
	</table>
</body>
	<script>
		function setId() {
			// signupForm페이지의 id 기입 input태그에 위에서 검사한 id값 적용 시키기.
			opener.document.inputForm.id.value="${trialid}";
			
			// 팝업창 화면 닫기
			self.close();
		}
	</script>

</c:if>
</html>






