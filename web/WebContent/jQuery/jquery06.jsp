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
		$("#s").click(function(){
			//$("img").show();
			$("img").fadeIn(2000, function(){alert("wow!!");});
			
		});		
		$("#h").click(function(){
			//$("img").hide();
			$("img").fadeOut(2000);
		});
/* 		$("#h").mouseover(function(){ // 올리는 순간 바로뜸
			alert("안녕!!");
		}); */
/* 		$("#h").mousedown(function(){
			alert("바보!!");
		}); */
	});

</script>
</head>
<body>
	<button id="s">show</button>
	<button id="h">hide</button><br/>
	<img src="img/beach.jpg" width="500"/>

</body>
</html>