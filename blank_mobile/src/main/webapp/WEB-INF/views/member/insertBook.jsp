<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>빈칸을 채우다.</title>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);
	/*로고 표시 */
	.book
	{
		position: relative;
		top: 100px;
		left:-100px;
		background-color:pink;
		width: 500px;
		height: 570px;
	}
	.aa
	{
		position: absolute;
		left: 120px;
		top: 100px;
		text-align: center;
		font-size: 20px;
		
	}
	#s1
	{
		position: relative;
		left: 170px;
		top: 500px;
	}
	#false
	{
		position: relative;
		left: 220px;
		top: 500px;
	}
	.containe
	{
		position: relative;
		width: 600px;
		height: 800px;
		top: -30px;
		margin: 0 auto;
	}
	.containerr
	{
		position: relative;
		top: 50px;
		left: 600px;	
		width: 400px;
	}
	
	.custom-size .colorpicker-saturation 
	{
		width: 250px;
		height: 250px;
	}
 
	.custom-size .colorpicker-hue,
	.custom-size .colorpicker-alpha 
	{
		width: 40px;
		height: 250px;
	}
 
	.custom-size .colorpicker-color,
	.custom-size .colorpicker-color div 
	{
		height: 40px;
	}
	
</style>

<!-- 색상구현 css -->
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
<link href="../resources/dist/css/bootstrap-colorpicker.css" rel="stylesheet">

<!-- 색상구현 자바스크립트 -->
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-3.2.1.js"></script>
<script src="../resources/dist/js/bootstrap-colorpicker.min.js"></script>


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="../resources/css/blank.css">
<script type="text/javascript" src="../resources/js/menu.js" ></script>

<script type="text/javascript">
	$(function() {
		
		$('#color-picker-size').colorpicker(
			{
				customClass: 'custom-size',
				sliders: {
				  saturation: {
					maxLeft: 250,
					maxTop: 250
				  },
				  hue: {
					maxTop: 250
				  },
				  alpha: {
					maxTop: 250
				}
			}
			 
		});
		
		$(".colorpicker-saturation").click(function() {
			
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
			console.log("일기장이 생성되었습니다.")
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
	
	<div class="containe">
		<div class="book">
			<form action="insertBook.do" method="post" id="f">
				<input type="hidden" name="mno" id="mno" value="${mno }">
				<input type="text" name="btitle" id="btitle" class="aa" maxlength="10" height="50" width="30" placeholder="제목">
				<div class="containerr">
					<div class="example-content well">
			       		<input id="color-picker-size" type="text" name="bcolor" class="form-control" placeholder="색상 선택" autocomplete="off"/>
			       </div>
				</div>
				<input class="btn btn-default" id="s1" type="submit" value="등록">
				<input class="btn btn-default" id="false" type="reset" value="취소">
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
</body>
</html>