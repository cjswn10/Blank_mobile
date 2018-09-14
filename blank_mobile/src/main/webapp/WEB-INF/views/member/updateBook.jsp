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
	.book
	{
		position: relative;
		top: 100px;
		left:50px;
		background-color:#ffc0cb;
		width: 100%;
		height: 300px;


	}
	#btitle
	{
		position: relative;
		top:-170px;
		width:75%;
		left: 75px;
		font-size: 15px;
		text-align: center;
	}

	#s1
	{
		position: relative;
		text-align:center;
		width:30%;
		font-size:80%;
		left: 80px;
		top: 50px;
	}
	#false
	{
		position: relative;
		text-align:center;
		left: 100px;
		width:30%;
		font-size:80%;
		top: 50px;
	}
	.containe
	{
		position: relative;
		width: 50%;
		height:100%;
		left: 20px;
		margin-top:20px;
		margin-bottom: 70px;
	}
	.containerr
	{
		position: relative;
		top: -280px;
		left: 60px;	
		width: 90%;
	}
	
</style>

<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">



<link rel="stylesheet" href="../resources/css/blank.css?ver=7">
<script type="text/javascript" src="../resources/js/menu.js?ver=6" ></script>
<script type="text/javascript" src="../resources/js/searchId.js?ver=7" ></script>
<script type="text/javascript">
	$(function() {
		
		setTimeout(function () {
			
			location.href = "logOut.do?id=${id}&autoOut=out";
			
		},10800*1000);
		
		
		$("#color-picker-size").change(function() {
			
			var color = $("#color-picker-size").val();
			
			$(".book").attr({
				style:"background-color:"+color
			})
			
		})
		
		$("#false").click(function() {
			re = confirm('작성하신 내용이 삭제될수 있습니다.\n사이트에서 나가시겠습니까?');
			if(re == true)
			{
				location.href="book.do"
			}	
			else
			{
				return;
			}	 
		})
		$("#s1").click(function() {
			console.log("일기장이 수정되었습니다.")
		})
		
		$( '#btitle') .on ("input ", function () {     
		    if (this.value.length> 8)         
		        this.value = this.value.slice (0,8); 
		});
		
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
			<input type="text" name="id" id="id" placeholder="검색할 아이디를 입력하세요!" autocomplete="off" style="color:#818181; background-color:#000000; border: none;">
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
	    <span style="cursor:pointer;" onclick="openSearch()" class="glyphicon glyphicon-search"></span>
	    <ul id="main_menu">
	        <li><a href="book.do">DIARY</a></li>
	        <li><a href="favorite.do">FAVORITES</a></li>
	        <li style="border: none"><a href="myPage.do">MYPAGE</a></li>

	    </ul>
	</nav>
	<input type="hidden" id="mno" name="mno" value="${mno }">
	<!----------- 내용 -------------->
	
	<div class="containe">
		
		<div class="book" style="background-color: ${b.bcolor}">
			
		</div>
		
		<form action="updateBook.do" method="post" id="f">
			<input type="hidden" name="bno" value="${b.bno }">
			<input type="text" id="btitle" maxlength="8" name="btitle" class="aa" value="${b.btitle }">
			<div class="containerr">
			    <input id="color-picker-size" type="color" name="bcolor" value="${b.bcolor }" class="form-control" autocomplete="off"/>	
			</div>
			<input class="btn btn-default" id="s1" type="submit" value="수정">
			<input class="btn btn-default" id="false" type="reset" value="취소">				
		</form>
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