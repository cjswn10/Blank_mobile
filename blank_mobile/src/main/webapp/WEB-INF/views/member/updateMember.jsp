<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
		content="width=device-width,
		initial-scale=1.0,
		maximum-scale=1.0,
		minimum-scale=1.0,
		user-scalable=no">
		
<title>빈칸을 채우다.</title>
<style type="text/css">

@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);
	
	
	#sub
	{
		font-family: 'Nanum Pen Script', serif;
		position: relative;
		font-size: 20px;
		
		
	}
	#s1
	{
		font-family: 'Nanum Pen Script', serif;
		position: relative;
		font-size: 20px;
		
	
	}
	.check
	{
		font-family: 'Nanum Pen Script', serif;
		position: relative;
		font-size: 50px;
		width: 500px;
		text-align: center;
	}
	
	.my
	{
		font-family: 'Nanum Pen Script', serif;
		position:relative;
		left:265px;
		top:-50px;
		font-size: 70px;
	}
	#tb
	{
		font-family: 'Nanum Pen Script', serif;
	}
	



</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<link rel="stylesheet" href="../resources/css/blank.css?">
<script type="text/javascript" src="../resources/js/menu.js" ></script>

<script type="text/javascript">
	$(function() {
		
		setTimeout(function () {
			
			location.href = "logOut.do?id=${id}&autoOut=out";
			
		},10800*1000);
		
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
		
		$("#sub").click(function() {
			console.log("회원정보가 수정 되었습니다.")
		})
		
		$("#s1").click(function() {
			re = confirm("작성하신 내용은 저장되지 않습니다.\n수정을 취소 하시겠습니까?")
			if(re)
			{
				location.href="myPage.do";
			}
			else
			{
				return;
			}	
		})
		
	})
</script>
</head>
<body>


	<!-- side-menu -->
<section id="mySidenav" class="sidenav">
	<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
	
	<a href="#"><img class="side_icon" src="../resources/img/icon/person.png">${id }님</a>
	<h5>회원정보</h5>
	<a href="pwdCheck.do?id=${id }">Edit</a>
	<a href="logOut.do?id=${id }">logout</a>
	<br>
	<h5>고객센터</h5>
	<a href="qNa.do">Contact</a>
	<br>
	<div class="side_icon_set">
		<a href="https://github.com/cjswn10/Blank_mobile"><img class="side_icon" alt="G" src="../resources/img/icon/git.png"></a>
		<a href="http://sc.bitcamp.co.kr/index.php?main_page=faq&action=use"><img class="side_icon" alt="B" src="../resources/img/icon/bit.png"></a>
	</div>
	
</section>




<div id="wrapper">

	<div class="mainSearchId" id="mainSearchId">
		<div class="mainSearchId_inner" id="mainSearchId_inner">
			<input type="text" name="id" id="id" placeholder="검색할 아이디를 입력하세요!" autocomplete="off" style="color:#818181; background-color:#000000; 

border: none;">
			<span id="btnMove" class="glyphicon glyphicon-search" ></span>
			<span onclick="closeSearch()" class="glyphicon glyphicon-remove"></span>
			
			<div id="searchid"></div>
		</div>
	</div>

		
	<!------ main-menu ------>
	<nav class="clearfix">
		<span id="menu" style="cursor:pointer;" onclick="openMenu()" class="glyphicon glyphicon-menu-hamburger"> </span>
	    <a href="main.do"><img src="../resources/img/blank.png" class="logo"></a>
	    <span style="cursor:pointer;" onclick="openNav()" class="glyphicon glyphicon-user"> </span>
	    
	    <ul id="main_menu">
	        <li><a href="book.do">DIARY</a></li>
	        <li><a href="favorite.do">FAVORITES</a></li>
	        <li style="border: none"><a href="myPage.do">MYPAGE</a></li>
	    </ul>
	</nav>	

	<div class="container">
	<div class="content" style="margin-top: 100px;text-align: center;">
		<h2>회원 정보 수정</h2>
		<hr>
		
		<div class="main">
		<form action="updateMember.do" method="post" class="f">
				<table id="tb" class="table"> 
					<tr>
						<td>아이디</td>
						<td>
							<input type="hidden" name="mno" id="mno" value="${mno }">
							<input type="text" class="form-control" name="id" id="id" value="${id }" readonly="readonly" style="text-align: center;">
						</td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td>
							<input type="password" class="form-control" name="pwd" id="pwd" style="text-align: center;" required="required">
						</td>
					</tr>
					<tr>
						<td>이름</td>
						<td>
							<input type="text" class="form-control" name="name" id="name" value="${m.name }" style="text-align: center;">
						</td>
					</tr>
					<tr>
						<td>휴대전화</td>
						<td>
							<input type="tel" class="form-control" name="phone" id="phone" maxlength="13" value="${m.phone }" style="text-align: center;">
						</td>
					</tr>
					<tr>
						<td>이메일</td>
						<td>
							<input type="email" class="form-control" name="email" id="email" value="${m.email }" style="text-align: center;">
						</td>
					</tr>
				</table>
				
					<input class="btn btn-default" type="submit" value="수정" id="sub">
					<input class="btn btn-default" type="reset" value="취소" id="s1">
					
				</form>
			</div>
		</div>
	</div>


	
	<!-- 푸터 -->
	<footer class="footer">
		<h3>비트와밀당하는 팀 X 빈칸 , 2018</h3>
		<ul class="list-inline">
	       <li>
	           <img alt="" src="../resources/img/ho.jpg" class="btn-social btn-outline">
	           <br><h5>김영호</h5>
	       </li>
	       <li>
	           <img alt="" src="../resources/img/adult.jpg" class="btn-social btn-outline">
	           <br><h5>변성인</h5>
	       </li>
	       <li>
	           <img alt="" src="../resources/img/min.jpg" class="btn-social btn-outline">
	           <br><h5>성민규</h5>
	       </li>
	       <li>
	           <img alt="" src="../resources/img/lim.jpg" class="btn-social btn-outline">
	           <br><h5>임연주</h5>
	       </li>
	       <li>
	           <img alt="" src="../resources/img/cha.jpg" class="btn-social btn-outline">
	           <br><h5>차건우</h5>
	       </li>
	    </ul>
	</footer>	
</div>
	
</body>
</html>