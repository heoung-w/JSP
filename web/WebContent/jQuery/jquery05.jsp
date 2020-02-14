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
		$("select").change(function(){
			$("h3").text($(this).val());
		});		
	});
</script>
</head>
<body>
	<h3>과목선택</h3>
	<select>	<!--  option jsp 선택, select value가 jsp가 된다. -->
		<option>java</option>
		<option>jsp</option>
		<option>framework</option>
		<option>project</option>
	</select>

</body>
</html>