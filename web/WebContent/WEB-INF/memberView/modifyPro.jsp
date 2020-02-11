<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="web.jspImgmember.model.MemberDAO"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css" >
</head>
<%
	if(session.getAttribute("memId") == null){	%>
		<script>
			alert("로그인 해주세요!");
			window.location.href="loginForm.jsp";
		</script>	
<%	}else{
		 request.setCharacterEncoding("UTF-8"); %>
		 
		<jsp:useBean id="member" class="web.jspImgmember.model.MemberDTO" />

<%
	//파일업로드 MultipartRequest
	String path = request.getRealPath("save");
	int max = 1024*1024*5;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);

	// 넘어오는 데이터 : 비밀번호, 생년월일, email
	// form에서 id 안넘옴 : id를 알기위해 session에서 id 꺼내기
	String id = (String)session.getAttribute("memId");
	member.setId(id);	// dto에 직접 id 세팅해서 
	
	member.setPw(mr.getParameter("pw"));
	member.setBirth(mr.getParameter("birth"));
	member.setEmail(mr.getParameter("email"));
	// DB 업데이트시, 기존의 사진 이름 정보 분실을 방지하기 위해 처리
	// 새로 파일 업로드를 하고 넘어 왔다면
	if(mr.getFilesystemName("photo") != null){
		// 새로 업로드한 input 태그에있는 사진이름으로 체워주고
		member.setPhoto(mr.getFilesystemName("photo"));
	}else{ // 새로 파일 업로드를 안했을 경우,
		// 기존의 파일 명으로 체워주기
		member.setPhoto(mr.getParameter("exPhoto"));
	}
		
	// db에 수정할 데이터를 dto 통으로 보내, 회원정보 수정하기.
	MemberDAO dao = MemberDAO.getInstance();
	dao.updateMember(member);
%>
<body>
	<br />
	<h1 align="center">회원 정보 수정</h1>
	<table>
		<tr>
			<td> <b>회원정보가 수정되었습니다.</b><br /> </td>
		</tr>
		<tr>
			<td>
				<button onclick="window.location.href='main.jsp'" > 메인으로 </button>
			</td>
		</tr>
	</table>
</body>

<%	} %>
</html>






