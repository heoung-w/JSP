<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout</title>
</head>
<%
	Cookie [] cs = request.getCookies();
	if(cs != null){
		for(Cookie coo : cs){
			if(coo.getName().equals("autoId") || coo.getName().equals("autoPw") || coo.getName().equals("autoCh")){
				coo.setMaxAge(0);
				response.addCookie(coo);
			}
		}
	}
	session.invalidate();
	response.sendRedirect("main.jsp");
	
%>

<body>

</body>
</html>