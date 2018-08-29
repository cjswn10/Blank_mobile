<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
   content="with=device-width,
initial-scale=1.0,
maximum-scale=1.0,
minimum-scale=1.0,
user-scalable=no">

<title>빈칸을 채우다.</title>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />

<style type="text/css">
ul{
   list-style:none;
   }
.content h2{
	text-align: center;
}
#favolist{
	display: table;
	margin-left: auto;	
}
#favolist > li{
	list-style: none;	
}
#favolist
{
	font-size: 30px;
}

</style>

<title>빈칸을 채우다.</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet" href="../resources/css/blank.css">
<script type="text/javascript" src="../resources/js/menu.js" ></script>
<script type="text/javascript">
	
	$(function() {		
		
		setTimeout(function () {
			
			location.href = "logOut.do?id=${id}&autoOut=out";
			
		},10800*1000);
		
		$(document).on("pageload", function(){
			window.location.reload(true);
		})
		var mno = ${mno}
		var listFavorite = function() {
			$.ajax({
			url:"listFavorite.do",
			data:{"mno":mno},				
			success:function(data) {				
				var list = eval("("+data+")");				

				$.each(list, function (i,f) {          
					var img = $("<img src='../resources/img/favoriteicon.png' width='70px'>")
					var a = $("<a data-ajax='false' href='othersDiary.do?id="+f.id+"&fno="+f.fno+"&fmno="+f.fmno+"'></a>").html(f.id+"님");		
					var li = $("<li></li>");
					var removeimg = $("<a href='deleteFavorite.do?mno=" + ${mno} + "&fmno="+f.fmno+"' class='glyphicon glyphicon-remove' id='plus_location'></a>");
					  
					$(li).append(img,a,removeimg);
					$("#list").append(li);
				});
			}});
		};
		listFavorite();
	});
</script>
</head>
<body>

	<div data-role="page">		
				
		<div data-role="content">
		
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
			<nav class="clearfix" style="margin-bottom: 20px">
				<span id="menu" style="cursor:pointer;" onclick="openMenu()" class="glyphicon glyphicon-menu-hamburger"> </span>
			    <a data-ajax="false" href="main.do"><img src="../resources/img/blank.png" class="logo"></a>
			    <span style="cursor:pointer;" onclick="openNav()" class="glyphicon glyphicon-user"> </span>
			    <span style="cursor:pointer;" onclick="openSearch()" class="glyphicon glyphicon-search"></span>
			    <ul id="main_menu">
			        <li><a href="book.do" data-ajax="false">DIARY</a></li>
			        <li><a href="favorite.do" data-ajax="false">FAVORITES</a></li>
			        <li style="border: none"><a href="myPage.do">MYPAGE</a></li>
			    </ul>
			</nav>		
		
			<ul data-role="listview" id="list"></ul>
		</div>
			
		<!--------- 푸터 ---------->
			<div class="footer">
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
			</div>	
		</div>
	</div>
</body>
</html>