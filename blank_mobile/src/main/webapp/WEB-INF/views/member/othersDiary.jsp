<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Do+Hyeon|Gaegu|Gamja+Flower|Jua|Nanum+Brush+Script|Nanum+Gothic+Coding|Nanum+Myeongjo|Nanum+Pen+Script|Source+Sans+Pro|Stylish|Sunflower:300" rel="stylesheet">

<title>빈칸을 채우다.</title>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

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
	font-size: 50px;
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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../resources/css/blank.css?ver=1">
<script type="text/javascript" src="../resources/js/menu.js" ></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.6.1.min.js"></script>
<link rel="stylesheet" href="../resources/css/blank.css">
<script type="text/javascript" src="../resources/js/menu.js" ></script>
<script type="text/javascript">

	$(function () {				
		
		var id = location.search.substring(4, location.search.indexOf("&"));
		var mno = ${mno}
		var fno = location.search.substring(location.search.indexOf("&")+5, location.search.lastIndexOf("&"));
		var fmno = location.search.substr(location.search.lastIndexOf("=")+1);
		$('#user_id').text(id + "님의 일기  ");
		$('	<img class="favoriteIcon" width="150" height="40" src="../resources/img/nfavorite.jpg">').appendTo('#user_id');
		if (fno.length <= 4) {
			$('.favoriteIcon').attr("src", "../resources/img/favorite.jpg")
		} 


	var othersDiaryList = function () {							
		$.ajax({
			url: "othersDiaryList.do",	
			data: {"fmno":fmno},
			success:function(data){				
				var list = eval("("+data+")");
				$.each(list, function(i, d) {
					var div = $('<div class="listdiary"></div>');						
					var a = $('<a href="detailFavoriteDiary.do?dno='+d.dno+'"></a>')
					var br = $('<br>');		
					var reContent = (d.dcontent).replace(/(?:\r\n|\r|\n)/g, '<br/>');
					var p = $('<div class="dcontent"></div>').html(reContent);
					$(".dcontent").scrollTop();
					$(p).attr({
						style: "font-family:"+d.dfont
					})            
					if (d.dphoto != null) {							
						var img = $('<img></img>').attr({
							src: "../resources/upload/" + d.dphoto,
							width: "353",
							height: "250"					
						});
						$(a).append(img);
						$(div).append(a,br,p);
						$("#main_container").append(div);
					}else {
						$(a).append(p);
						$(div).append(a);
						$("#main_container").append(div);
					}	
					
					if (d.dfile != null) {							
						var img = $('<img></img>').attr({
							src: "../resources/upload2/" + d.dfile,
							width: "353",
							height: "250"					
						});
						$(a).append(img);
						$(div).append(a,br,p);
						$("#main_container").append(div);
					}else {
						$(a).append(p);
						$(div).append(a);
						$("#main_container").append(div);					
					}     
				})	
		}})		
	};
	othersDiaryList();		
	
	//즐겨찾기에서 들어갔을 때
	if (fno.length <= 4) {
		$('.favoriteIcon').toggle(function(){
			//즐겨찾기에서 삭제
			$(this).attr("src","../resources/img/nfavorite.jpg")				
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
			$(this).attr("src", "../resources/img/nfavorite.jpg")				
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
	
	<div class="content" style="margin-top: 100px">
		<div id="user_id"></div>	
	
		<div id="main">
			<div id="main_container">
				
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