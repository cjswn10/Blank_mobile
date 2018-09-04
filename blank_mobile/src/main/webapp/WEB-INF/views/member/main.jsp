<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
		content="width=device-width,
		initial-scale=1.0,
		maximum-scale=1.0,
		minimum-scale=1.0,
		user-scalable=no">

<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);
/*a 파란색 지우기 */
 a:link { color: black; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: black; text-decoration: none;}

#mainList{
	text-align: center;
}

.modalContent{
	white-space: pre-line;
}


.diaryimg{
    max-height: 100%;
    max-width: 100%;
    width: 300px;
    height: 300px;
}

.dform {
    width: 300px;
    height: 300px;
    display: inline-block;
    cursor: pointer;
}

.contents{	
	width: 300px;
	height: 300px;
	position: absolute;
	white-space: pre-line;
	background-color: pink;
	opacity: 0.8;
	overflow: hidden;	
}

.iljung-div{
    display:flex;
    flex-direction:row;
    justify-content : space-around;
    width:80%;
    margin-left: auto;
    margin-right: auto;
    margin-top: 15%;
    margin-bottom: 15%;
    text-align : center;
   
}

.iljung-date-div .btn{
    border:1px solid #EFE7E6;
    background-color: #EFE7E6;
    color:#662408;
    font-family: 'Nanum Pen Script', serif;
}

.landing {
    width: 100%;
    height: 89%;
    margin: auto;
    background-size: cover;
    padding: 0;
    background-color: #ebcfce;
    background-image: url(../resources/img/mainlogo.jpg);
    background-repeat: no-repeat;
    background-position: right;
    background-size: auto 80%;
}

#searchid
	{
		border: 1px solid black;
		height: 150px;
		background: white;
		color: black;
	}
#top
	{
		display:none;
		position:fixed;
		bottom:10px;
		right:2px;
	}	

@media screen and (max-width: 670px) and (min-width: 541px) {	
	.landing {
	    width: 100%;
	    height: 80%;
	    margin: auto;
	    background-size: cover;
	    padding: 0;
	    background-color: #ebcfce;
	    background-image: url(../resources/img/mainlogo_mobile.jpg);
	    background-repeat: no-repeat;
	    background-position: right;
	    background-size: auto 80%;
	}
	
	.iljung-div{
    display:flex;
    flex-direction:row;
    justify-content : space-around;
    width:80%;
    margin-left: auto;
    margin-right: auto;
    margin-top: 10%;
    margin-bottom: 15%;
    text-align : center;
   
	}
}

@media screen and (max-width: 540px) {	
	.landing {
	    width: 100%;
	    height: 70%;
	    margin: auto;
	    background-size: cover;
	    padding: 0;
	    background-color: #ebcfce;
	    background-image: url(../resources/img/mainlogo_mobile.jpg);
	    background-repeat: no-repeat;
	    background-position: right;
	    background-size: auto 100%;
	}
	
	.iljung-div{
    display:flex;
    flex-direction:row;
    justify-content : space-around;
    width:80%;
    margin-left: auto;
    margin-right: auto;
    margin-top: 10%;
    margin-bottom: 15%;
    text-align : center;
   
	}
	
}
</style>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<!-- Jquery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.3.5/jquery.fancybox.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.3.5/jquery.fancybox.min.js"></script>


<link rel="stylesheet" href="../resources/css/blank.css?ver=16">
<script type="text/javascript" src="../resources/js/menu.js?ver=7" ></script>

<script type="text/javascript">
$(function () {
	
	setTimeout(function () {
		
		location.href = "logOut.do?id=${id}&autoOut=out";
		
	},10800*1000);
	
	var mno = ${mno}
	
	//일간키워드
	$.ajax({
		url: "dailyKeyword.do",
		success: function(data) {
			console.log("일간키워드 success")
			dailyfname = data;
			console.log(dailyfname)
			var dailyImg = $('<img></img>').attr({
				src: "../resources/rImg/" + dailyfname,
				width: "100%"
			})
			
			$("#statisticsD").append(dailyImg);
		}
	});
	
	//주간키워드
	$.ajax({
		url: "weeklyKeyword.do",
		success: function(data) {
			console.log("주간키워드 success")
			weeklyfname = data;
			console.log(weeklyfname)
			var weeklyImg = $('<img></img>').attr({
				src: "../resources/rImg/" + weeklyfname,
				width: "100%"
			})
			
			$("#statisticsW").append(weeklyImg);
		}
	});
	
	//메인리스트
	$.ajax({
		url: "mainList.do",
		success:function(data){				
			var list = eval("("+data+")");
			$.each(list, function(i, d) {
				
				var font = $('<font color=" "></font>')					
				var contents = $('<div class="contents"></div>').html(d.dcontent);
				$(font).append(contents);
				
				var diaryDiv = $('<div class="dform"></div>');
				
				var div = $("<img class='diaryimg'></img>").attr({
					src : "../resources/upload2/"+d.dfile
				})

				if (d.dfile == null && d.dphoto != null) {
					$(div).attr({
						src : "../resources/upload/"+d.dphoto
					})
				}else if (d.dfile == null && d.dphoto == null){
					$(div).attr({
						src: '../resources/upload/standard.png'
					})
				}
				
				//fancybox를 위한 a태그와 div
				var a = $('<a data-fancybox="gallery" data-src="#modal'+ d.dno +'" href="javascript:;"></a>');
				var modalBox = $('<div style="display: none;" id="modal'+d.dno+'"></div>');
				var contentsDiv = $('<div></div>');

				var otherid = d.id;
				var writer = $("<h5></h5>").html(otherid);
				var dtitle = $("<h5></h5>").html(d.dtitle);
				var ddate = $("<h5></h5>").html(d.ddate);
				var dweather = $("<h5></h5>").html(d.dweather);
				var dcontent = $("<h5 class='modalContent'></h5>").html(d.dcontent);
				
				//우선순위 1.그림 2.사진 3.기본이미지 순으로 하나만 보여주기
				var src = "../resources/upload2/" + d.dfile;
				if(d.dfile == null && d.dphoto != null) {
					src = "../resources/upload/" + d.dphoto;
				} else if (d.dfile == null && d.dphoto == null) {
					//src = "../resources/upload/standard.png";
					src = 0;
				}
				var filephoto = $("<img></img>").attr({
					src : src,
					width : "90%"
				});
				
				if(src == 0) {
					$(contentsDiv).append(writer, dtitle, ddate, dweather, dcontent);	
					
				} else {
					$(contentsDiv).append(writer, dtitle, ddate, dweather, filephoto, dcontent);	
				}
				
				
				//친구일기장으로 가는 태그
				var others = $('<a href="othersDiary.do?id='+otherid+'&fmno='+d.mno+'"></a>');
				
				$(others).click(function(){
						
					$.ajax({
						url:"listFavorite2.do",
						data:{"mno":d.mno},
						success:function(data)
						{
							location.href="othersDiary.do?id="+d.id+"&fmno="+d.mno+"";
							var arr = eval("("+data+")");		
							$.each(arr,function(i,a){
								if(a.mno == mno )
								{
									location.href="othersDiary.do?id="+d.id+"&fno="+a.fno+"&fmno="+d.mno+"";
								}				
							})
						}
					})//ajax
				})
				
				$(others).append(contentsDiv);
				$(modalBox).append(others);
				$("#modal").append(modalBox);
				
				
				$(diaryDiv).append(div);
				
				$(a).append(diaryDiv);
				$('#mainList').append(a);
				/* 웹버전용
				$(diaryDiv).hover(function() {
					$(div).detach();
					$(this).append(contents);
				}, function() {		
					$(this).append(div);
					$(contents).detach();
					$(font).detach();
				})
				
				*/
			})
		}
	})
	
	
	$("#searchid").hide();
	
	$("#id").keyup(function() {

		$("#searchid").empty();
		$.ajax({
			url:"mainSearchId.do",
			data:{"id":this.value},
			success:function(data)
			{

				var arr = eval("("+data+")")
				$.each(arr,function(i,v){
					var id = $("<span></span>").html(v.id);
					var br = $("<br>");
					$("#searchid").append(id,br);
					
					$("#searchid").click(function(){
						$(this).hide();
					})
					
					$(id).click(function() {
						$("#id").val(v.id);
						$("#searchid").hide();	
						$.ajax({
							url:"listFavorite2.do",
							data:{"mno":v.mno},
							success:function(data)
							{
								location.href="othersDiary.do?id="+v.id+"&fmno="+v.mno+"";
								var arr = eval("("+data+")");		
								$.each(arr,function(i,a){
									if(a.mno == mno )
									{
										location.href="othersDiary.do?id="+v.id+"&fno="+a.fno+"&fmno="+v.mno+"";
									}				
								})
							}
						})//ajax
					})
          

					$("#btnMove").one("click",function(){
							$.ajax({
								url:"checkId2.do",
								data:{"id":$("#id").val()},
								success:function(data)
								{
									if($.trim(data) == 0){
					                    location.href="#";
					                    return;
					                }
					                else{
					                	
					                	$("#searchid").empty();
					                	$("#id").val(v.id)
					                	$.ajax({
											url:"listFavorite2.do",
											data:{"mno":v.mno},
											success:function(data)
											{
												location.href="othersDiary.do?id="+v.id+"&fmno="+v.mno+"";
												var arr = eval("("+data+")");		
												$.each(arr,function(i,a){
													if(a.mno == $("#mno").val() )
													{
														location.href="othersDiary.do?id="+v.id+"&fno="+a.fno+"&fmno="+v.mno+"";
													}				
												})
											}

										})//ajax
									
					                	}
					                }
								})//ajax

					          })
						
							});
						}
					})
				if(this.value != "")
				{
					$("#searchid").show();	
				}
				else
				{
					$("#searchid").hide();
				}
		})		
		
		
		$(window).scroll(function(){
			
			if($(this).scrollTop() > 50)
			{
				$("#top").fadeIn();
			}
			else
			{
				$("#top").fadeOut();
			}
			
		})
		
		$("#top").click(function(){
		
			$("body").scrollTop(0);
			
		})
		
		
})
</script>
<title>빈칸을 채우다.</title>
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
		<div class="landing">
			<!--  <img src="../resources/img/mainlogo.jpg" height="50%"> -->
		</div>
		
		<!-- 페이지 버튼 -->
		<div class="iljung-div">
                    <div class="iljung-date-div"><p class="btn btn1" rel="div2"><a href="#mainList">뉴스피드</a></p></div>
                    <div class="iljung-date-div"><p class="btn btn1" rel="div1"><a href="#statisticsD">주요키워드</a></p></div>
                    <!-- <div class="iljung-date-div"><p class="btn btn1" rel="div3"><a href="#foot">개발자</a></p></div>  -->
        </div>
		<!----------- 내용 -------------->
		
		<div class="clearfix" id="mainList"></div>
		
		<!-- modal들을 넣을 div -->
		<div id="modal"></div>
			
		<div id="statisticsD" style="margin-top: 10%;"><h2>DAILY KEYWORDS</h2></div>
		<div id="statisticsW"><h2>WEEKLY KEYWORDS</h2></div>
		
		<img id="top" src="../resources/img/top.PNG">
		
			<!--------- 푸터 ---------->
		<div class="footer" id="foot">
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
	
</body>
</html>