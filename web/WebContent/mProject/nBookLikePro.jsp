<%@page import="web.project.model.FishDTO"%>
<%@page import="web.project.model.FishDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>

<%
			int num = 0;
			if(request.getParameter("num") != null){
				num = Integer.parseInt(request.getParameter("num"));
			}
			String pageNum = null;
			if(request.getParameter("pageNum") != null){
				pageNum = request.getParameter("pageNum");
			}else{
				pageNum = "1";
			}
		if(session.getAttribute("memId") == null){ %>
			<script>
			   alert("로그인 해주세요!!");
			   window.location.href="nContentForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
			</script>
		<% }else{

				request.setCharacterEncoding("UTF-8");
				
				
				
				String id = (String)session.getAttribute("memId");
				FishDAO dao = FishDAO.getInstance();
				/* FishDTO likefish = dao.getFishLike(num); */
				String fishId = dao.getFishId(num,id); // 중복확인용 아이디 받은 것
		%>
		<jsp:useBean id="likely" class = "web.project.model.FishDTO"></jsp:useBean>
		<jsp:setProperty property="*" name="likely"/>
		
			
		<%		
		
				// 좋아요 메서드 호출 
				/* int liked = likefish.getLiked(); //좋았어요 */
				
				if (!id.equals(fishId)){ //세션 아이디 값이랑 좋아요 할 때 받은 아이디랑 다를 시만 메서드 실행
					
					dao.like(num,id);// likely 에 bk num 일때 bk id  값을 추가
					dao.likeUp(num);
					%>
					<script>
					alert("좋아요 +1");
					window.location.href="nContentForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
					</script><!-- num parameter을 생성해서 넘어가줘야지만 다시 n contentform 으로 넘어가도 num 파라미터가 존재함 
					북리스트에서 콘텐츠폼으로 넘어갈때도 파라미터를 생성해야 하지만 콘텐츠폼에서 프로로 실행 할때 
					파라미터를 넘겼다가 다시 콘텐츠 폼으로 넘어갈때 파라미터 값을 받으려면 또 파라미터를 생성 해줘야 한다 -->
					
					<% }else{ %>
					<% 
						dao.likeDelete(num,id);
					    dao.likeDown(num);
					%>			
					<script>
					alert("좋아요 취소!!");
					window.location.href="nContentForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
					</script>
			<% } %>
	<% } %>
</html>