<%@page import="web.project.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>deletePro</title>
</head>
<%
	if(session.getAttribute("memId") == null) {  %>
		<script>
			alert("로그인 해주세요!");
			window.location.href="mLoginForm.jsp";
		</script>
	
<%	}else{ 
		// 회원 탈퇴 로직 작성
		// DB 에서 데이터 삭제 
		// session에서 아이디 꺼내기
		String id = (String)session.getAttribute("memId");
		// 폼페이지에서 넘어온 비밀번호 받기
		String pw = request.getParameter("pw");
	
		MemberDAO dao = new MemberDAO();
		int result = dao.deleteMember(id, pw);
		
		// result : -1 (아이디 이상함,세션생성부분확인), 0 (비번 오류), 1(탈퇴 정상처리)
		if(result == 1) {	// 탈퇴 처리가 됬다면,
			// 로그아웃
			session.invalidate();
			// 쿠키 있으면 쿠키도 삭제
			Cookie[] cs = request.getCookies();	// request에서 전체쿠기 가져오기
			if(cs != null){	// 쿠키가 있다면, 
				for(Cookie coo : cs){ // 반복문 돌려서 모든 쿠키에 접근
					// 쿠키 이름 뽑아, 저장할때 붙힌 이름과 비교해서 동일하면 삭제
					if(coo.getName().equals("autoId") || coo.getName().equals("autoPw") || coo.getName().equals("autoCh") ){	 
						coo.setMaxAge(0);
						response.addCookie(coo);
					}
					
				}
			}						%>
		
		<body>
			<script>
				alert("회원탈퇴가 완료 되었습니다.!!");
				window.location.href="mMain.jsp";
			</script>
		</body>
		
<%		}else{	// 비밀번호 오류 : 회원탈퇴 실패	%>
		
			<script>
				alert("비밀번호가 맞지 않습니다.");
				history.go(-1);
			</script>
	
<%		}	
	}// 로그인 체크 else 닫는 괄호
%>


</html>




