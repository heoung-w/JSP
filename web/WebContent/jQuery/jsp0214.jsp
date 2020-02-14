<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src= "https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
	<script>
	
		/*
		// script alert 띄우기. 
		function test(){
			alert("test!!");
		}
		*/
		
		/* 
		// 1. 함수만드는 방법
		$(function(){
			alert("jQuery ready")
		})
		*/
		
		//2. 문서 불러와 JQUERY 적용 방법 함수만들기.
		$(document).ready(function(){
			$("input").click(function(){
				alert("Jquery btn clicked!!");
			})
		})
		$
		
	
	
	</script>

<body>
	<input type="button" value="btsJS" onclick="test()">
	<input type="button" value="btsJQuery" onclick="test()">
	<h2>hello</h2>
	<h1>haha</h1>

</body>
</html>