
<%@page import="web.jspMember.model.memberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>loginPro</title>
</head>
<%
	// 로그인된 상태일때,
	if(session.getAttribute("memId") != null){ %>
		<script>
			alert("이미 로그인된 상태입니다.");
			window.location.href="main.jsp";
		</script>
		
<%	}else{ 	// 비 로그인 상태일때, 

		// id,pw 받아서 db연결해 일치하는지 확인.
		request.setCharacterEncoding("UTF-8");
		// loginForm 에서 전달받은 파라미터 받기 
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String auto = request.getParameter("auto"); // 자동로그인 파리미터 받기
		
		// 메인에서 세션없고, 쿠키가 있어서 이리로 넘어올때 처리 
		// loginForm을 타고 온것이 아니라 위에 getParameter로 값 꺼낼 수 없다. 모두 null 상태
		// 쿠키 꺼내서 위 변수 체워주기 
		Cookie[] cs = request.getCookies();
		if(cs != null){
			for(Cookie coo : cs){
				if(coo.getName().equals("autoId")) id = coo.getValue();
				if(coo.getName().equals("autoPw")) pw = coo.getValue();
				if(coo.getName().equals("autoCh")) auto = coo.getValue();
			}
		}
		
		// 로그인 체크
		memberDAO dao = new memberDAO();
		boolean check = dao.loginCheck(id, pw);
		
		if(check) { // id-pw 일치할때
			// 세션 만들기 : 로그인 성공으로 앞으로 로그인상태 유지 시켜줄 세션 만들어주기.
			session.setAttribute("memId", id);
			// 자동로그인 체크 하고 로그인버튼 눌렀을때 ---> 쿠키 생성
			if(auto != null){ // 자동로그인 체크했다면,
				// 쿠키 객체 생성
				Cookie c1 = new Cookie("autoId", id);
				Cookie c2 = new Cookie("autoPw", pw);
				Cookie c3 = new Cookie("autoCh", auto);
				// 쿠키들 유효기간 설정
				c1.setMaxAge(60*60*24);
				c2.setMaxAge(60*60*24);
				c3.setMaxAge(60*60*24);
				// 적용
				response.addCookie(c1);
				response.addCookie(c2);
				response.addCookie(c3);
			}
			
			// main 돌아가기
			response.sendRedirect("main.jsp");
			
		}else{	// id-pw 불일치 할때   %> 
		
			<script>
				alert("아이디 또는 비밀번호가 틀렸습니다.");
				history.go(-1);
			</script>	
<%		}
	}
%>

<body>

</body>
</html>