<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src= "https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	$(document).ready(function(){
		window.setInterval("time()", 1000);
		// inter = window.setInterval("time()", 1000);
	});
	
	function time(){
		$.ajax({
			type : "GET",
			url : "ajax01.jsp",
			success : function(data){
				$("#time").html(data);
				// clearInterVal(inter); interval 없애기 딱 한번만 실행.
			},
			error : function(){
				// 오류 메세지...
			}
		});
	}

</script>
</head>
<body>
	<h2> 시간나오시오~~<label id = "time"></label></h2>
</body>
</html>