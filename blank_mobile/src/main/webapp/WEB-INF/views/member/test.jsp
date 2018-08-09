<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#test
	{
		border: 1px solid black;
		width: 150px;
		height: 150px;
	}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		
		$("#test").hide();
		
		$("#searchId").keyup(function() {
			
			$("#test").empty();
			$.ajax({
				url:"mainSearchId.do",
				data:{"id":this.value},
				success:function(data)
				{
					var arr = eval("("+data+")")
					$.each(arr,function(i,v){
						var id = $("<sapn></span>").html(v.id);
						var br = $("<br>");
						$("#test").append(id,br);
						
						$(id).click(function() {
							$("#searchId").val(v.id)
							$("#test").hide();	
							location.href="favoritesDiary.do?fmno="+v.mno+"&id="+v.id+"";
						})
						$("#btnMove").click(function(){
							location.href="favoritesDiary.do?fmno="+v.mno+"&id="+v.id+"";
						})
						
					})
				}
			})
			
			if(this.value != null)
			{
				$("#test").show();	
			}	
			
		})
		
		
	})
</script>
</head>
<body>
	<div class="mainSearchId">
		<input type="text" name="searchId" id="searchId">
		<button id="btnMove">이동</button>
		<div id="test"></div>
	</div>
	
</body>
</html>