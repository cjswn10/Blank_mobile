<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Do+Hyeon|Gaegu|Gamja+Flower|Jua|Nanum+Brush+Script|Nanum+Gothic+Coding|Nanum+Myeongjo|Nanum+Pen+Script|Source+Sans+Pro|Stylish|Sunflower:300" rel="stylesheet">
<title>빈칸을 채우다.</title>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

.ul-link { color:#242424; font-weight:200; }

.ddate{	
	text-align: right;	
}

#diaryImg{
	width: 100%;
	height: 100%;
}

.favoriteIcon:hover{
	/* box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19); */
	opacity: .8;
	/* background: #fff; */
	/* transform: scale(1.1); */
	transform: scale(1.1);
}

.favoriteIcon{
	cursor: pointer;
	width: 120px;
	height: 40px;
	transition: transform 0.3s;
}
#user_id {
	font-family: 'Nanum Pen Script', serif;
	font-size: 20px;
	text-align: center;
}

	/* 일기장 목록 컨테이너 */
	#main_container
	{
		
		width: 960px;
		margin: 0 auto;
		
	}

	/* 일기장 목록을 포괄하는 div 화면보다 넘어가면 숨김 */
	#main
	{
		overflow: hidden;
	}
	/* 서브컨테이너의 자식 div들 */
	#main_container > div
	{
		position:relative;
		width: 350px;
		float: left;
		margin: 50px;
		padding: 10px;
		font-size: 30px;
		
	}
	
	.dcontent{
		border: 1px solid black;
		border-radius: 10px;
		width: 353px;
		height: 250px;
		overflow: auto;
	}

</style>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../resources/css/blank.css?ver=5">
<script type="text/javascript" src="../resources/js/menu.js" ></script>
<script type="text/javascript" src="../resources/js/searchId.js" ></script>
<script type="text/javascript">

	$(function () {				
		
		setTimeout(function () {
			
			 $('html, body').scrollTop(0);
				
			},100);
		
		setTimeout(function () {
			
			location.href = "logOut.do?id=${id}&autoOut=out";
			
		},10800*1000);
		
		var id = location.search.substring(4, location.search.indexOf("&"));
		var mno = ${mno}
		var fno = location.search.substring(location.search.indexOf("&")+5, location.search.lastIndexOf("&"));
		var fmno = location.search.substr(location.search.lastIndexOf("=")+1);
		$('#user_id').text(id + "님의 일기  ");
		$('	<img class="favoriteIcon" width="150" height="40" src="../resources/img/nfavorite.png">').appendTo('#user_id');
		if (fno.length <= 4) {
			$('.favoriteIcon').attr("src", "../resources/img/favorite.jpg")
		} 


	var othersDiaryList = function () {							
		$.ajax({
			url: "othersDiaryList.do",	
			data: {"fmno":fmno},
			success:function(data){	
				var list = eval("("+data+")");
				$.each(list, function(idx, d) {
					 
					var li = $('<li data-icon="false"></li>');
					$(li).attr("idx",idx);			
					var a = $('<a data-ajax="false" href="detailFavoriteDiary.do?dno='+d.dno+'"></a>')
					var title = $('<span></span>').html(d.dtitle);
					var content = $('<p></p>').html(d.dcontent);				
					var ddate = $('<p class="ddate" style="font-size: 8px;"></p>').html(d.ddate);					
					
					if (d.dphoto != null && d.dfile != null) {							
						var img = $('<img></img>').attr({
							src: "../resources/upload/" + d.dphoto,
							width: "100%",
							height: "100%"					
						});
						$(a).append(img, title, content, ddate);
						$(li).append(a);
						$('#list').append(li);
					} else if(d.dphoto != null && d.dfile == null){
						var img = $('<img></img>').attr({
							src: "../resources/upload/" + d.dphoto,
							width: "100%",
							height: "100%"					
						});
						$(a).append(img, title, content, ddate);
						$(li).append(a);
						$('#list').append(li);
					} else if(d.dphoto == null && d.dfile != null){
						var img = $('<img></img>').attr({
							src: "../resources/upload2/" + d.dfile,
							width: "100%",
							height: "100%"					
						});
						$(a).append(img, title, content, ddate);
						$(li).append(a);
						$('#list').append(li);				
					} else{
						$(a).append(title, content, ddate);
						$(li).append(a);
						$('#list').append(li);							
					}	
					/* if (d.dfile != null) {							
						var img = $('<img></img>').attr({
							src: "../resources/upload2/" + d.dfile,
							width: "100%",
							height: "100%"					
						});
						$(a).append(img, title, content, ddate);
						$(li).append(a);
						$('#list').append(li);
					}else {
						$(a).append(title, content, ddate);
						$(li).append(a);
						$('#list').append(li);					
					}					 */						 				
				})
				$('#list').listview("refresh");
		}})		
	};
	othersDiaryList();		
	
	//즐겨찾기에서 들어갔을 때
	if (fno.length <= 4) {
		$('.favoriteIcon').toggle(function(){
			//즐겨찾기에서 삭제
			$(this).attr("src","../resources/img/nfavorite.png")				
			$.ajax({
				url: "deleteFavorite.do",
				data: {"fmno":fmno,"mno":mno},
				success:function(data){
					console.log("삭제 완료");
				}
			})  				
		},function(){
			//즐겨찾기에 추가
			$(this).attr("src","../resources/img/favorite.jpg")
			$.ajax({
				url: "insertFavorite.do",
				data: {"fmno":fmno, "mno":mno},
				type: "POST",
				success:function(data){
					console.log("추가완료");
				}
			}) 
		})
	//검색으로 들어갔을 때
	}else{
		//즐겨찾기에 추가
		$('.favoriteIcon').toggle(function () {
			$(this).attr("src", "../resources/img/favorite.jpg")
			$.ajax({
				url: "insertFavorite.do",
				data: {"fmno":fmno, "mno":mno},
				type: "POST",
				success:function(data){
					console.log("추가 완료")
				}
			})				
		}, function(){
			//즐겨찾기에서 삭제
			$(this).attr("src", "../resources/img/nfavorite.png")				
			$.ajax({
				url: "deleteFavorite.do",
				data: {"fmno":fmno,"mno":mno},				
				success:function(data){
					console.log("삭제 완료")
				}
			})				
		})	 		
	}	
});	
</script>
</head>
<body>

	<div data-role="page">		
				
		<div data-role="content" style="padding: 0;overflow:hidden;">
		<!-- side-menu -->
		<section id="mySidenav" class="sidenav">
			<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
			<a href="#"><img class="side_icon" src="../resources/img/icon/person.png">${id }님</a>
			<h5>회원정보</h5>
			<a href="pwdCheck.do?id=${id }" data-ajax="false">Edit</a>
			<a href="logOut.do?id=${id }" data-ajax="false">logout</a>
			<br>
			<h5>고객센터</h5>
			<a href="qNa.do" data-ajax="false">Contact</a>
			<br>
			<div class="side_icon_set">
				<a href="https://github.com/cjswn10/Blank_mobile"><img class="side_icon" alt="G" src="../resources/img/icon/git.png"></a>
				<a href="http://sc.bitcamp.co.kr/index.php?main_page=faq&action=use"><img class="side_icon" alt="B" src="../resources/img/icon/bit.png"></a>
			</div>
		</section>

		<div id="wrapper">	
	
			<div class="mainSearchId" id="mainSearchId" data-role="footer" style="display:none;background-color:black;">
				<div class="mainSearchId_inner" id="mainSearchId_inner">
					<input type="text"  data-role="none" name="id" id="id" placeholder="검색할 아이디를 입력하세요!" autocomplete="off" style="color:#818181; background-color:#000000; border: none;">
					<span id="btnMove" class="glyphicon glyphicon-search" style="color:white" ></span>
					<span onclick="closeSearch()" class="glyphicon glyphicon-remove" style="color:white"></span>
					
					<div id="searchid" style="color:white;"></div>
				</div>
			</div>
			
			<!------ main-menu ------>
			<nav class="clearfix" style="margin-bottom: 20px">
				<span id="menu" style="cursor:pointer;" onclick="openMenu()" class="glyphicon glyphicon-menu-hamburger"> </span>
			    <a data-ajax="false" href="main.do"><img src="../resources/img/blank.png" class="logo"></a>
			    <span id="btnn" style="cursor:pointer;" onclick="openNav()" class="glyphicon glyphicon-user"> </span>
			    <span style="cursor:pointer;" onclick="openSearch()" class="glyphicon glyphicon-search"></span>
			    <ul id="main_menu">
			        <li><a href="book.do" data-ajax="false">DIARY</a></li>
			        <li><a href="favorite.do" data-ajax="false">FAVORITES</a></li>
			        <li style="border: none"><a href="myPage.do" data-ajax="false">MYPAGE</a></li>
			    </ul>
			</nav>
					
			<div id="user_id"></div>
				
			<ul data-role="listview" data-theme="d" id="list" style="margin-bottom:10px;padding: 15px;"></ul>						
			
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
</div>
</body>
</html>