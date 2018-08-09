<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">

.modalContent{
	white-space: pre-line;
}

.diaryimg{
/*
	position: relative;    
    width: 300px;
    height: 300px;
    background-size: contain;
	background-repeat: no-repeat;
    vertical-align: middle;
  */  
    
    max-height: 100%;
    max-width: 100%;
    width: 300px;
    height: 300px;
     
}

.dform {

    float: left;
    width: 300px;
    height: 300px;
    margin: 4px;
    cursor: pointer;
}
/*
.dform:last-child {
    margin-right: 0;
    
}
*/
.contents{	
	width: 300px;
	height: 300px;
	position: absolute;
	white-space: pre-line;
	background-color: pink;
	opacity: 0.8;
	overflow: hidden;	
}

@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

<!-- 랜딩 컨테이너 작업  -->
.container {
    width: 960px;
    margin: 0 auto;
}

.landing {
    width: 70%;
    height: 600px;
    margin: auto;
    
    background-image: url("../resources/img/mainlogo.jpg");
    
    background-size: cover;
    background-position: center center;
}
.landing > .container {
    padding-top: 200px;
}

.blog {
	position: relative;
 	margin: 0 auto;
    padding: 100px 0;
    width: 1240px;
}


#searchid
	{
		border: 1px solid black;
		height: 150px;
		background: white;
		color: black;
	}

</style>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<!-- Jquery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.3.5/jquery.fancybox.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.3.5/jquery.fancybox.min.js"></script>


<link rel="stylesheet" href="../resources/css/blank.css?ver=10">
<script type="text/javascript" src="../resources/js/menu.js?ver=1" ></script>

<script type="text/javascript">
$(function () {
	var mno = ${mno}
	
	$.ajax({
		url: "mainList.do",
		success:function(data){				
			var list = eval("("+data+")");
			$.each(list, function(i, d) {
				
				var font = $('<font color=" "></font>')					
				var contents = $('<div class="contents"></div>').html(d.dcontent);
				$(font).append(contents);
				
				/*
				var diaryDiv = $('<div class="dform"></div>').attr({
					onclick: "location.href='mainDetailDiary.do?dno="+d.dno+"'"
				})
				*/
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
				var modalBox = $('<div style="display: none;max-width:800px;" id="modal'+d.dno+'"></div>');
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
					src = "../resources/upload/standard.png";
				}
				var filephoto = $("<img></img>").attr({
					src : src,
					width : "400px",
				});
				
				$(contentsDiv).append(writer, dtitle, ddate, dweather, filephoto, dcontent);	
				
				
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
				
				$(diaryDiv).hover(function() {
					$(div).detach();
					$(this).append(contents);
				}, function() {		
					$(this).append(div);
					$(contents).detach();
					$(font).detach();
				})
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


<div class="mainSearchId" id="mainSearchId">
	<div class="mainSearchId_inner" id="mainSearchId_inner">
		<input type="text" name="id" id="id" placeholder="검색할 아이디를 입력하세요!" autocomplete="off" style="width:940px; color:#818181; background-color:#000000; border: none;">
		<span id="btnMove" class="glyphicon glyphicon-search" ></span>
		<span onclick="closeSearch()" class="glyphicon glyphicon-remove"></span>
		
		<div id="searchid"></div>
	</div>
</div>

<div id="wrapper">
	
	
	<!-- main-menu -->
	<nav class="clearfix">
	    <a href="main.do"><img src="../resources/img/blank.png" class="logo left"></a>
	    <span style="cursor:pointer;padding: 20px 20px;" onclick="openNav()" class="glyphicon glyphicon-menu-hamburger"> </span>
	    <span style="cursor:pointer;padding: 20px 20px;" onclick="openSearch()" class="glyphicon glyphicon-search"></span>
	    <ul>
	        <li><a href="book.do">DIARY</a></li>
	        <li><a href="favorite.do">FAVORITES</a></li>
	        <li><a href="myPage.do">MYPAGE</a></li>
	    </ul>
	</nav>

	
	
		<div class="landing">
			<div class="container">
	
			</div>
			
		</div>

</div>
	
<div class="container">
	   <div class="blog" align="center">
	   		<div class="clearfix" id="mainList"></div>
	   </div> 	    
</div>
	

<!-- modal들을 넣을 div -->
<div id="modal"></div>
		


<!-- 푸터입니다.  -->
<footer class="footer">
	<h3>비트와밀당하는 팀 X 빈칸 , 2018</h3>
	<ul class="list-inline" style="margin-bottom: 0;">
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