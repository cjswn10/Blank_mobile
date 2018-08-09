<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>빈칸을 채우다.</title>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

	.content{
		text-align: center;
	}
	
	.check > span{
		font-size: 50px;
	}
	
	#pwd
	{
		position: relative;
		font-size:16px;
		width:250px;
		top: -5px;
		left: 10px;
	}

	.container2
	{
		width: :600px;
	}
	#d
	{
		font-family: 'Nanum Pen Script', serif;
		font-size:30px;
		position: relative;
		top:220px;
		left:430px;
		width:300px;
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
			$("#d").html("");
		},5000);
		
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
	<a href="logOut.do">logout</a>
	<br>
	<h5>고객센터</h5>
	<a href="qNa.do">Contact</a>
	<br>
	<div class="side_icon_set">
		<a href="https://github.com/cjswn10/Blank"><img class="side_icon" alt="G" src="../resources/img/icon/git.png"></a>
		<a href="http://sc.bitcamp.co.kr/index.php?main_page=faq&action=use"><img class="side_icon" alt="B" src="../resources/img/icon/bit.png"></a>
	</div>
	
</section>

<div id="wrapper">

	<!-- main-menu -->
	<nav class="clearfix">
	    <a href="main.do"><img src="../resources/img/blank.png" class="logo left"></a>
	    <span style="cursor:pointer" onclick="openNav()">&#9776; </span>
	    <ul>
	        <li><a href="book.do">DIARY</a></li>
	        <li><a href="favorite.do">FAVORITES</a></li>
	        <li><a href="myPage.do">MYPAGE</a></li>
	    </ul>
	</nav>

	

	<div class="content" style="margin-top: 180px">
		<div class="container2">
		<div class="check">
			<h2><span>본인확인</span></h2><br>
			<h2><span>고객님의 소중한 개인정보보호를 위해서 본인확인을 진행합니다.</span></h2>

      
		</div>
		
		<div id="d"><font color="red">${msg }</font></div>
		
		<div>
			<form action="pwdCheck.do" method="post" class="f">
				<input type="hidden" name="id" id="id" value="${id }"><br>
				<input type="hidden" name="mno" id="mno" value="${mno }"><br>
				<label for="pwd">비밀번호 : </label><input type="password" name="pwd" id="pwd"><br>
				<input class="btn btn-default" type="submit" value="확인" id="sub">
			</form>
		</div>

	</div>
	</div>
</div>
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
	
	
	


</body>
</html>