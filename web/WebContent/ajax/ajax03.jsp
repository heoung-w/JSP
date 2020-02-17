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
		$("button").click(function(){
			$.ajax({
				type : "POST",
				url : "ajax04.jsp",
				data : {id : $("#id").val(), pw : $("#pw").val()},
				success : function(data){	// data 꼭 안써도됨 a , b 아무거나 적어도됨.
					$("#result").html(data);
					$("#result").css("color", "red");
				}
			});	
		});
	});

</script>
<body>
<input type="text" id = "id" name="id"/> <br/>
<input type="text" id = "pw" name="pw"/>
<button>전송</button>
<div id= "result"></div>
</body>
</html>