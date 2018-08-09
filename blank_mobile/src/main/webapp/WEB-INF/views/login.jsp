<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>빈칸을 채우다.</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="resources\img/favicon.ico"/>
<!--===============================================================================================-->


<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/css/util.css">
	<link rel="stylesheet" type="text/css" href="resources/css/login.css">
<!--===============================================================================================-->

</head>
<body>

	<div class="limiter">
		<div class="container-login100">
		
			<div class="wrap-login100 p-b-160 p-t-50">
				<form class="login100-form validate-form" action="login.do" method="post">
					<span class="login100-form-title p-b-43">
						<img src="resources/img/loginlogo2.gif" width="400px">
						
						
						 
					</span>
					<!-- 로그인 입니다 -->

						<div class="wrap-input100 rs1 validate-input" data-validate = "Username is required">
							<input class="input100" type="text" name="id" placeholder="아이디" autocomplete="off">
							<span class="label-input100"></span>
						</div>
						
						
						<div class="wrap-input100 rs2 validate-input" data-validate="Password is required">
							<input class="input100" type="password" name="pwd" placeholder="비밀번호" autocomplete="off">
							<span class="label-input100"></span>
						</div>
						
						
						<div class="container-login100-form-btn">
							<button class="login100-form-btn" type="submit">
								로그인
							</button>
						</div>
						
						
					
					<!-- 회원가입 입니다.  -->
					
					<div class="text-center w-full p-t-23">
						<a href="join.do" class="txt1">
							회원가입
						</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						
						<a href="search.do" class="txt1">
							계정을 잊으셨나요?
						</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	

	
	
<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>
	
</body>
</html>