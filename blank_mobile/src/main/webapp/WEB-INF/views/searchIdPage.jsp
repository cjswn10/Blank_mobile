<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html manifest="resources/conf/bit.manifest">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="with=device-width,
initial-scale=1.0,
maximum-scale=1.0,
minimum-scale=1.0,
user-scalable=0">
<title>빈칸을 채우다.</title>

<link rel="stylesheet" type="text/css" href="resources/css/login.css">

<style type="text/css">

	.main
	{
		position:relative;
		top:100px;
		width: 800px;
		height: 350px;
		text-align: center;

	}
	.phrases
	{
		position: relative;
		top: -100px;
		text-align: center;
	}
	.phrases1
	{
		font-size: 15px;
	}
	.phrases2
	{
		position:relative;
		font-size: 10px;
	}
	.infomation
	{
		font-size: 30px;
		position: relative;
		top: 30px;
		text-align: center;
	}
	#searchId
	{	
		position: relative;
		top: 50px;
		text-align: center;
	}
	#tb
	{
		position: relative;
		font-size:20px;
		width: 100%;
		height: 100%;
	}
	#name
	{
		width: 243px;
		height: 30px;
	}
	#phone
	{
		width: 100%;
		height: 30px;
	}
	#dd
	{
		width: 40px;
		height: 30px;
	}
	.glyphicon-search
	{
		font-size: 100%;
	}

</style>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		 
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
		
		$("#searchId").click(function() {
			$.ajax({
				url:"searchId.do",
				data:{"name":$("#name").val(),"phone":$("#phone").val()},
				success:function(data)
				{
					if(data != "")
					{
						var re = confirm("고객님의 아이디는 "+data+" 입니다.")
						if(re)
						{
							location.href="login.do";
						}
						else
						{
							return;
						}
					}
					else
					{
						confirm("고객님의 정보를 확인해주세요.")
					}	
				}
			})
		})
		
	})
</script>
</head>
<body>
<div class="container-login100">
   
	<div class="main">
		<div class="phrases">
			<span class="glyphicon glyphicon-search"></span>
			<span class="phrases1">회원정보에 등록한 이름과 휴대전화 ID 찾기</span><br>
			<span class="phrases2">회원정보에 등록한 휴대전화 번호와 입력한 휴대전화 번호가 같아야 합니다.</span>
		</div>
		<div class="infomation">
			<table id="tb">
				<tr>
					<td align="center" width="150">이름</td>
					<td width="200">
						<input type="text" name="name" id="name" placeholder="이름" style="text-align: center;" >
					</td>
				</tr>
				<tr>
					<td align="center">휴대전화</td>
					<td>
						<input type="tel" name="phone" id="phone" maxlength="13" placeholder="휴대전화" style="text-align: center;" >
					</td>
				</tr>
			</table>
				<button id="searchId">확인</button>
		</div>
	</div>
</div>	
</body>
</html>