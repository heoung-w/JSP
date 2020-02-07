<%@page import="web.project.model.MemberDAO"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	// 로그인된 상태일때,
	if(session.getAttribute("memId") != null){ %>
		<script>
			alert("이미 로그인된 상태입니다.");
			window.location.href="mMain.jsp";
		</script>
		
<%	}else{ 	// 비 로그인 상태일때, 

	request.setCharacterEncoding("UTF-8");

	//로그인 확인 작업. form 페이지에 있는 값들 데이터 추출
	String id = request.getParameter("id");//내가 form페이지에서 입력한 id를 추출
	String pw = request.getParameter("pw");
	String auto = request.getParameter("auto"); // 자동로그인 파리미터 받기
	
	Cookie[] cs = request.getCookies();
	if(cs != null){
		for(Cookie coo : cs){
			if(coo.getName().equals("autoId")) id = coo.getValue();
			if(coo.getName().equals("autoPw")) pw = coo.getValue();
			if(coo.getName().equals("autoCh")) auto = coo.getValue();
		}
	}
	
	//DB에 저장된 회원들 데이터에서 ID와 PW가 일치하는 정보가 있는지 확인하기 위해서 
	MemberDAO dao = new MemberDAO();
	boolean check = dao.mLoginCheck(id , pw);
	
	if(check){
		// 세션 만들기 : 로그인 성공으로 앞으로 로그인상태 유지 시켜줄 세션 만들어주기.앞으로 어떤 id로 로그인을 하면 memId에 담아서 세션 생성
		session.setAttribute("memId", id);//session.setAttribute(세션 이름, 세션 값)
	
		response.sendRedirect("mMain.jsp");
	}else{ %>
		<script>
			alert("아이디 또는 비밀번호가 일치하지 않습니다");
			history.go(-1);
		</script>
	<% }
}
%>
<body>

</body>
</html>