<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1.0, user-scalable=no" />
<title>빈칸을 채우다.</title>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);
	.book
	{
		position: relative;
		top: 130px;
		left:50px;
		width: 100%;
		height: 300px;

	}
	#btitle
	{
		position: relative;
		top:-140px;
		width:75%;
		left: 75px;
		font-size: 15px;
		text-align: center;
	}

	#s1
	{
		position: relative;
		width:50px;
		left: 90px;
		top: 80px;
	}
	#false
	{
		position: relative;
		left: 110px;
		width:50px;
		top: 80px;
	}
	.containe
	{
		position: relative;
		width: 50%;
		top: -30px;
		left: 20px;
	}
	.containerr
	{
		position: relative;
		top: -250px;
		left: 60px;	
		width: 90%;
	}
	
</style>

<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">



<link rel="stylesheet" href="../resources/css/blank.css">
<script type="text/javascript" src="../resources/js/menu.js" ></script>

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
		<a href="https://github.com/cjswn10/Blank"><img class="side_icon" alt="G" src="../resources/img/icon/git.png"></a>
		<a href="http://sc.bitcamp.co.kr/index.php?main_page=faq&action=use"><img class="side_icon" alt="B" src="../resources/img/icon/bit.png"></a>
	</div>
	
</section>	

<div id="wrapper" data-role="none">
	
	<!-- main-menu -->
	<nav class="clearfix">
	    <a href="main.do" data-ajax="false"><img src="../resources/img/blank.png" class="logo left"></a>
	    <span style="cursor:pointer" onclick="openNav()">&#9776; </span>
	    <ul>
	        <li><a href="book.do" data-ajax="false">DIARY</a></li>
	        <li><a href="favorite.do" data-ajax="false">FAVORITES</a></li>
	        <li><a href="myPage.do" data-ajax="false">MYPAGE</a></li>
	    </ul>
	</nav>
	
	<div class="containe">
		
		<div class="book" style="background-color: ${b.bcolor}" data-role="none">
			
		</div>
		
		<form action="updateBook.do" method="post" id="f" data-ajax="false">
			<input type="hidden" name="bno" value="${b.bno }">
			<input data-role="none" type="text" id="btitle" maxlength="8" name="btitle" class="aa" value="${b.btitle }">
			<div class="containerr">
			    <input data-role="none" id="color-picker-size" type="color" name="bcolor" value="${b.bcolor }" class="form-control" autocomplete="off"/>	
			</div>
			<input data-role="none" class="btn btn-default" id="s1" type="submit" value="수정">
			<input data-role="none" class="btn btn-default" id="false" type="reset" value="취소">				
		</form>
		
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
</body>
</html>