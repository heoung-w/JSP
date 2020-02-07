<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<link href="style2.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		function validate1(){
			var ds=document.ds;
			if(!ds.search.value){
				alert("검색어를 입력하세요");
				return false;
			}
		}
	</script>
</head>
<%
	// 로그인 상태확인	
	// 세션이 없다면 로그인을 하지 않은 상태
if(session.getAttribute("memId") == null){//로그인 안했다면,
	
			String id = null, pw = null;
			Cookie[] cs = request.getCookies();
			
			if(cs != null){	// 쿠키가 있다면
				for(Cookie coo : cs){ // 쿠키들 반복
					if(coo.getName().equals("autoId")) id = coo.getValue();
					if(coo.getName().equals("autoPw")) pw = coo.getValue();
				}
			}			
			if(id != null && pw != null){
				response.sendRedirect("mLoginPro.jsp");
			}
%>
<body>
	<header>		
		<div class="wrapper">
			<nav>
				<ul>
					<li><a href="mMain.jsp"><img src="img\noname3.png" height="155" width="160"/></a>
					<li class="ccc"><a href='mBookListForm.jsp'>책 목록 전체보기</a></li>
					<li class="ccc"><a href='mBookListForm.jsp?genre=판타지'>판타지</a></li>
					<li class="ccc"><a href='mBookListForm.jsp?genre=공포'>공포</a></li>
					<li class="ccc"><a href='mBookListForm.jsp?genre=로맨스'>로맨스</a></li>
					<li class="ccc"><a href='nBookListForm.jsp'>야너두작가될수있어</a></li>	
					<li class="aaa"><a href='mSignupForm.jsp'>회원가입</a></li> 
					<li class="aaa"><a href='mLoginForm.jsp'>로그인</a></li>
				</ul>
			</nav>
		</div>
	</header>
</body>

<body>
	<div class="bbb" style="text-align: center;">
	<form class="form-inline" action = "mBookListForm.jsp" method ="post" name="ds" onsubmit="return validate1();">
		<div class="form-group">
			<div class="input-group">
				<div class="input-group-addon">
					<select name = "sel" style=" height: 30px;" class="form-control">
					<option value ="bk_name">제 목</option><%--value => DB에 있는 이름으로 써야 함.--%>
					<option value ="bk_writer">저 자</option>					
					</select>
					<input type="text" name ="search" style="width: 400px;  height: 30px;" class="form-control" >
				</div>
				<div class="input-group-addon">
					<input type="submit" value ="검색" style="height: 30px;"class="btn btn-default">
				</div>
			</div>
		</div>
	</form>
</div>				
</body>
<% }else{ //로그인 했다면,	
	String id=(String)session.getAttribute("memId");
%>
<body>
	<header>
		<div class="wrapper">
			<nav>
				<ul>
					<li><a href="mMain.jsp"><img src="img\noname3.png" height="155" width="160"/></a>
					<li class="ccc"><a href='mBookListForm.jsp'>책 목록 전체보기</a></li>
					<li class="ccc"><a href='mBookListForm.jsp?genre=판타지'>판타지</a></li>
					<li class="ccc"><a href='mBookListForm.jsp?genre=공포'>공포</a></li>
					<li class="ccc"><a href='mBookListForm.jsp?genre=로맨스'>로맨스</a></li>
					<li class="ccc"><a href='nBookListForm.jsp'>야너두작가될수있어</a></li>	
				</ul>
				<ul>
					<li class="aaa"><a href='mLogOut.jsp'>로그아웃</a></li>				
					<li class="aaa"><a href='mMypageForm.jsp'>마이페이지</a></li>	
						<%if(id!=null&&id.equals("admin")){ %>
					<li class="aaa"><a href='mAllprice.jsp'>총 매출</a></li>
					<li class="aaa"><a href='mMemberList.jsp'>회원 리스트</a></li>
						<%} %> 
					<li class="aaa"><%=session.getAttribute("memId")%>님 환영합니다</li>
				</ul>
			</nav>
		</div>
</header>	
</body>
<body>


<div class="bbb" style="text-align: center;">
	<form class="form-inline" action = "mBookListForm.jsp" method ="post" name="ds" onsubmit="return validate1();">
		<div class="form-group">
			<div class="input-group">
				<div class="input-group-addon">
					<select name = "sel" style=" height: 30px;" class="form-control">
					<option value ="bk_name">제 목</option><%--value => DB에 있는 이름으로 써야 함.--%>
					<option value ="bk_writer">저 자</option>					
					</select>
					<input type="text" name ="search" style="width: 400px;  height: 30px;" class="form-control" >
				</div>
				<div class="input-group-addon">
					<input type="submit" value ="검색" style="height: 30px;"class="btn btn-default">
				</div>
			</div>
		</div>
	</form>
</div>				
</body>
<% } %>
</html>