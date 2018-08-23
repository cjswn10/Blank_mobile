<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1.0, user-scalable=no" />
<title>빈칸을 채우다.</title>

<link rel="stylesheet" type="text/css" href="resources/css/login.css">

<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<style type="text/css">
	.main
	{
		width:300px;
		font-size:15px;
		position: relative;
		text-align: center;
		left: -105px;
	}
	.id
	{
		position:relative;
		width: 60%;
		height:300px;
		top:50px;
		left: 150px;
	}
	.pwd
	{
		position:relative;
		width: 60%;
		height:300px;
		top:-10px;
		left: 150px;
	}
	#searchId
	{
		position:relative;
		font-size: 20px;
		top:80px;
		left: 10px;
	}
	#searchPwd
	{
		position:relative;
		font-size: 20px;
		top:80px;
		left: 10px;
	}
</style>
</head>
<body>
<div class="container-login100">
	<div class="main">
		<div class="id">
			<span class="glyphicon glyphicon-yen" style="left: 40px;top:30px"></span>
			<span style="position:relative;top:70px">아이디를<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;찾으시겠습니까?</span>
			<br>
			<br>
			<a href="searchIdPage.do" id="searchId" class="txt1">아이디찾기</a>
		</div>
		<div class="pwd">
			<span class="glyphicon glyphicon-ruble" style="left: 50px;top:30px"></span>
			<span style="position:relative;top:70px">비밀번호를<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;찾으시겠습니까?</span>
			<br>
			<br>
			<a href="searchPwdPage.do" id="searchPwd" class="txt1">비밀번호찾기</a>
		</div>
	</div>
</div>	
</body>
</html>