<%@page import="web.project.model.CharDAO"%>
<%@page import="web.project.model.MemberDAO"%>
<%@page import="web.project.model.BookDTO"%>
<%@page import="web.project.model.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href = "style.css" rel = "stylesheet" type = "text/css"/>

</head>
<% 
		
	if(session.getAttribute("memId")== null){ %>
			<script>
				alert("로그인후 이용해주세요");
				window.location.href="mLoginForm.jsp";
			</script>
	<% }else{ 
		
			String id = (String)session.getAttribute("memId");
			String number = request.getParameter("number");
			int money = Integer.parseInt(request.getParameter("money"));
			int total = Integer.parseInt(request.getParameter("total"));
			int point = Integer.parseInt(request.getParameter("point"));
			
			String [] nums = number.split(",");
			
			// 내 포인트가 구매금액보다 클경우 구매번호를 하나씩 넣어줘
			if(money >= total){
				
					MemberDAO dao = new MemberDAO();
					CharDAO charge = CharDAO.getInstance();
					// 구매한 책을 내 buylist에 저장.
					for(int i =1; i < nums.length; i++){
						String num = nums[i];
						dao.InsertBuyList(id, num);
					}
					// 구매한 책을 내 장바구니에서 삭제
					for(int i =1; i < nums.length; i++){
						String num = nums[i];
						dao.myShopDeleteList(id,num);
					}
					
					// 구매내역 테이블에 저장
					charge.InsertCharList(number, id, total);
					
					// 내 포인트도 수정 해줘야지	
					int result = dao.downPoint(id, point);
					if(result == 1){ %>
						<script>
							alert("구매완료!!");
							history.go(-2);
						</script>
					<% }else{ %>
						<script>
							alert("구매실패!!");
							history.go(-1);
						</script>
					<%}
				
			}else{ %>
					<script>
						alert("잔액이 모자랍니다!! 포인트를 충전해주세요 ㅎ");
						history.go(-1);
					</script>
		 <% } %>

<body>
</body>
  <% } %>
</html>