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

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=TJJZXTuJHDxAWrWZPEdS&submodules=geocoder"></script>

<link rel="stylesheet" href="../resources/css/blank.css?ver=7">
<script type="text/javascript" src="../resources/js/menu.js?ver=2" ></script>

<script type="text/javascript" src="../resources/js/searchId.js?ver=7" ></script>

<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);
</style>


<script type="text/javascript">
	$(function() {
		setTimeout(function () {
			
			location.href = "logOut.do?id=${id}&autoOut=out";
			
		},10800*1000);
		
		
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

	<!------ main-menu ------>
	<div class="mainSearchId" id="mainSearchId">
		<div class="mainSearchId_inner" id="mainSearchId_inner">
			<input type="text" name="id" id="id" placeholder="검색할 아이디를 입력하세요!" autocomplete="off" style="color:#818181; background-color:#000000; border: none;">
			<span id="btnMove" class="glyphicon glyphicon-search" ></span>
			<span onclick="closeSearch()" class="glyphicon glyphicon-remove"></span>
			
			<div id="searchid"></div>
		</div>
	</div>
	
	<input type="hidden" id="mno" name="mno" value="${mno }">
		
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
		
	
	<div class="content" style="margin-bottom:20px;">
			<div class="row">
				<div id="map" style="width:100%;height:400px;"></div>
			</div>
			<br>
			<br>
			<div class="row">
				<div class="col-md-6">
 					<h3>Location</h3>
 					<h5>서울 마포구 백범로 23 구프라자 3층</h5><br>
 					<h3>Tel</h3>
					<h5>(010)-7706-2878</h5>
	 			</div>
	 			<br>
 				<div class="col-md-6">
 					<h3>STAFF</h3>
 					<h5>비트밀당조</h5><br>
 					<h3>Email</h3>
 					<h5>flsh22@naver.com</h5>
 				</div>

			</div>
	</div>


	
	<script>
      var map = new naver.maps.Map('map');
      var myaddress = '서울 마포구 백범로 23';// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
      naver.maps.Service.geocode({address: myaddress}, function(status, response) {
          if (status !== naver.maps.Service.Status.OK) {
              return alert(myaddress + '의 검색 결과가 없거나 기타 네트워크 에러');
          }
          var result = response.result;
          var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
          map.setCenter(myaddr); // 검색된 좌표로 지도 이동
          // 마커 표시
          var marker = new naver.maps.Marker({
            position: myaddr,
            map: map
          });
      });
	</script>
	
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

