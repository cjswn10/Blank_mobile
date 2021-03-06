<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- CSS 및  js -->
	<title>빈칸을 채우다.</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="resources\img/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/css/util.css">
	<link rel="stylesheet" type="text/css" href="resources/css/main.css">
	<link rel="stylesheet" type="text/css" href="resources/css/login.css">
<!--===============================================================================================-->


<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(function() {
	
	//아이디 중복확인
	$("#id").keyup(function() {
		
		var id = $(this).val()
		var patten = /\s/g;
		var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
		var hangle = /[ㄱ-힣]/;
		var capital_letter = /[A-Z]/


		if(id.match(patten) || id.match(special_pattern))
		{
			 $('#checkMsg').html('<p style="color:#F2594B;font-size:13px;">유효하지 않은 아이디 형식입니다.</p>');
			 return false;
		}
		else if(id.match(hangle))
		{
			$('#checkMsg').html('<p style="color:#F2594B;font-size:8px;">아이디는 영문자 및 숫자만 사용가능합니다.</p>');
			 return false;
		}
		else if(id.match(capital_letter))
		{
			$('#checkMsg').html('<p style="color:#F2594B;font-size:12px;">아이디는 소문자만 사용가능합니다.</p>');
			 return false;
		}
		else if(id == "")
		{
			$('#checkMsg').html('');
			 return false;
		}
		else if(id.length < 3 || id.length > 15)
		{
			$('#checkMsg').html('<p style="color:#F2594B;font-size:10px;">아이디는 3~15자까지 입력 가능합니다.</p>');
			 return false;
		}
		
		$.ajax({
			url:"checkId.do",
			data:{"id":$("#id").val()},
			success:function(data)
			{
				if($.trim(data) == 0){
                    $('#checkMsg').html('<p style="color:blue">사용가능한 아이디입니다.</p>');
                }
                else{
                    $('#checkMsg').html('<p style="color:#F2594B">이미 사용중인 아이디입니다.</p>');
                }
			}
		})
	})
	
	//비밀번호 체크
	$("#pwd").keyup(function() {
		
  		var pwd = $(this).val();
		
		if(pwd == "")
		{
			$("#checkMsg2").html("");
			$("#checkPwd").html("");
			
		}
		else if(pwd.length < 3 || pwd.length > 15)
		{
			$('#checkMsg2').html('<p style="color:#F2594B;font-size:10px;">비밀번호는 3~15자까지 입력 가능합니다.</p>');
		}
		else
		{
			$('#checkMsg2').html('<p style="color:blue;font-size:10px;">사용 가능한 비밀번호입니다.</p>');
		}
	});
	
  	$("#pwd2").keyup(function() {
  		
		if($("#pwd").val() != $("#pwd2").val()){
			$("#checkPwd").html("비밀번호가 일치하지 않습니다").attr("style", "color:#F2594B");
		}
		else if($(this).val() == "")
		{
			$("#checkPwd").html("");
		}
		else{
			$("#checkPwd").html("비밀번호가 일치 합니다.").attr("style", "color:blue");
		}
		
	});
  	
  	//이름 검사
  	$("#name").keyup(function() {
  		
  		var name = $(this).val()	
  		var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
  		var hangle = /[ㄱ-ㅎ]/
  		
		if(name.match(special_pattern) || name.match(hangle))
		{
			$('#checkName').html('<p style="color:#F2594B;font-size:10px;">유효하지 않은 이름 형식입니다.</p>');
		}
		else if(name == "")
		{
			$("#checkName").html("");
		}
		else
		{
			$('#checkName').html('<p style="color:blue;font-size:10px;">사용 가능한 이름입니다.</p>');
		}	
		
	});
  	
  	//전화번호 자동 - 추가
  	$("#phone").keyup(function() {
		var textinput = $("#phone").val();
		textinput = textinput.replace(/[^0-9]/g, '');
		var tmp = ""

		if (textinput.length > 3 && textinput.length <= 7) {
			tmp += textinput.substr(0, 3);
			tmp += '-';
			tmp += textinput.substr(3);
			$("#phone").val(tmp);
		} else if (textinput.length > 7) {
			tmp += textinput.substr(0, 3);
			tmp += '-';
			tmp += textinput.substr(3, 4);
			tmp += '-';
			tmp += textinput.substr(7);
			$("#phone").val(tmp);
		}
	});

})
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
/*
.container-login100 {
	width: 400px;
	margin-left: auto;
    margin-right: auto
}
*/
</style>
</head>
<body>
<div class="container-login100">
	
	<form action="join.do" method="post">
		<h2>회원가입 </h2>
		<div class="form-group">
		    <label>아이디 </label>
		    <input type="text" class="form-control" name="id" id="id" maxlength="16" placeholder="아이디" autocomplete="off" required="required">
		    <span id="checkMsg"></span>
		</div>
		<div class="form-group">
		    <label>비밀번호 </label>
		    <input type="password" class="form-control" name="pwd" id="pwd" maxlength="16" placeholder="암호" autocomplete="off" required="required">
		    <span id="checkMsg2"></span>
	    </div>
	    <div class="form-group">
		    <label>비밀번호확인 </label>
		    <input type="password" class="form-control" id="pwd2" placeholder="암호확인" maxlength="16" autocomplete="off" required="required">
		    <span id="checkPwd"></span><br>
	    </div>
	    <div class="form-group">
		    <label>이름  </label>
		    <input type="text" class="form-control" id="name" name="name" placeholder="이름" maxlength="15" autocomplete="off" required="required">
		    <span id="checkName"></span>
	    </div>
	    <div class="form-group">
		    <label>이메일 </label>
		    <input type="email" class="form-control" name="email" placeholder="이메일" maxlength="30" autocomplete="off" required="required">
	    </div>
	    <div class="form-group">
		    <label>연락처 </label>
		    <input type="tel" class="form-control" id="phone" name="phone" maxlength="13" placeholder="연락처" autocomplete="off" required="required">
	    </div>
	
	   <button type="submit" class="btn btn-default">가입</button>
	</form>
</div>
</body>
</html>