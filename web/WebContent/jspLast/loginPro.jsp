<%@page import="web.jspLast.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Login Pro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");

	String pageNum = "";
	String from = "";
	if(request.getParameter("pageNum") != null){
		pageNum = request.getParameter("pageNum");
		from = request.getParameter("from");
	}
	
	String uri = "";
	if(!from.equals("")){
		uri = from+".jsp?pageNum="+pageNum;
	}else{
		uri = "main.jsp";
	}
	
	// # 세션이 있을 경우
	if(session.getAttribute("memId") != null){%>
		<script>
			window.location="<%=uri%>";
		</script>
<%	}else{	// # 세션이 없을경우 
	
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String auto = request.getParameter("auto");	
		
		
		Cookie [] cs = request.getCookies();
		if(cs != null){  
			for(Cookie coo : cs){
				if(coo.getName().equals("autoId")) id = coo.getValue();
				if(coo.getName().equals("autoPw")) pw = coo.getValue();
				if(coo.getName().equals("autoCh")) auto = coo.getValue();
			}
		}
		
		// # 세션은 없고 쿠키 또는 넘어온 파라미터가 있을경우
		if(id != null){
			
			MemberDAO dao = MemberDAO.getInstance();
			boolean res = dao.loginCheck(id, pw);	
		
			if(res){ 
				if(auto != null) {		
					Cookie c1 = new Cookie("autoId", id);
					Cookie c2 = new Cookie("autoPw", pw);
					Cookie c3 = new Cookie("autoCh", auto);
					c1.setMaxAge(60*60*24);		
					c2.setMaxAge(60*60*24);		
					c3.setMaxAge(60*60*24);		
					response.addCookie(c1);
					response.addCookie(c2);
					response.addCookie(c3);
				}
				session.setAttribute("memId", id);	
						
				
				%>
				<script>
					window.location='<%=uri%>';		
				</script>	
				
<%			}else{ // # 비밀번호 틀렸을 경우%>
				<script>
					alert("아이디 또는 비밀번호가 틀렸습니다.");
					history.go(-1);
				</script>
<%			}%>
<%		}else{	 %>
			<script>
				alert("로그인 하세요.");
				window.location="<%=uri%>";
			</script>
<%		}%>
<%	}%>
<body>

</body>
</html>