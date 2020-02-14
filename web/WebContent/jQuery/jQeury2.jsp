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
		
		$(document).ready(function(){
			$("li:nth-chid(2)").css("color","red");
		});
	</script>
<body>

	<h3>hello</h3>
	<h3 id="id">select</h3>
	<h3 class="cls">class</h3>
	
	<ul>
		<li>1.text 1.text</li>
		<li>2.text 2.text</li>
		<li>3.text 3.text</li>
		<li>4.text 4.text</li>
	</ul>
</body>
</html>