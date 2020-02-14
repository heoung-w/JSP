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
		$("button").click(function(){
			alert($("#id1").val());
			$("h3").text("확인완료!!!");
			$("#id1").val("");
		});
	});
</script>
</head>
<body>
<h3>입력값 확인하기</h3>
<input type="text" name="id" id="id1"/>
<button>확인</button>
</body>
</html>