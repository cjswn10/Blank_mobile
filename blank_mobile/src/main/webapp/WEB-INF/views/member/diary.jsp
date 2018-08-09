<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Do+Hyeon|Gaegu|Gamja+Flower|Jua|Nanum+Brush+Script|Nanum+Gothic+Coding|Nanum+Myeongjo|Nanum+Pen+Script|Source+Sans+Pro|Stylish|Sunflower:300" rel="stylesheet">

<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

.selectBook
{
	width: 960px;
	margin: 0 auto;
}

.insertForm{
	border: 1px solid black;
	width: 960px;
	margin: 0 auto;
	text-align: center;
}
/*insert 아이콘*/


.gi-5x{
	font-size: 50px;
	position: relative;
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
	
	.diarytitle{
		font-family: 'Nanum Pen Script', cursive;
		border: 1px solid black;
		border-radius: 10px;
		
	}
	
	.footer{
		margin-top: 5%;
	}

	

</style>

<title>빈칸을 채우다.</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="../resources/css/blank.css?ver=1">
<script type="text/javascript" src="../resources/js/menu.js" ></script>


<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function () {
		var mno = ${mno}		
		var bno = document.location.search.substr(14);

		
		var selectBook = function(){
			$.ajax({
				url:"listBook.do",
				data:{"mno":mno},
				success:function(data)
				{
					var list = eval("("+data+")")
					$.each(list,function(i,b){
						var btitle = $("<option value="+b.bno+"></option>").html(b.btitle);
						$(".btitle").append(btitle);
									
					})
				}
			})
		};
		
		$(".btitle").change(function(){
			var btitle = $(".btitle").val();
			location.href="diary.do?mno="+mno+"&bno="+btitle+""
		})
		
		var listDiary = function () {
			
			$.ajax({
				url: "listDiary.do",	
				data: {"bno":bno,"mno":mno},
				success:function(data){				
					var list = eval("("+data+")");
					$.each(list, function(i, d) {
						//날짜 날씨 제목 그림 사진 글
						var div = $('<div class="listdiary"></div>');
						var title = $('<div class="diarytitle">제목:'+d.dtitle+'</div>');
						
						var a = $('<a href="detailDiary.do?dno='+d.dno+'"></a>')
						var br = $('<br>');
					
						var reContent = (d.dcontent).replace(/(?:\r\n|\r|\n)/g, '<br/>');
						
						var p = $('<div class="dcontent"></div>').html(reContent);
						$(p).attr({
							style: "font-family:"+d.dfont
						})
            			$("dcontent").scrollTop();
						if (d.dphoto != null) {							
							var img = $('<img></img>').attr({
								src: "../resources/upload/" + d.dphoto,
								width: "353",
								height: "250"					
							});
							$(a).append(img);
							$(div).append(title,a,br,p);
							$("#main_container").append(div);
						}else {
							$(a).append(p);
							$(div).append(title,a);
							$("#main_container").append(div);					
						}		            
						
						if (d.dfile != null) {							
							var img = $('<img></img>').attr({
								src: "../resources/upload2/" + d.dfile,
								width: "353",
								height: "250"					
							});
							$(a).append(img);
							$(div).append(title,a,br,p);
							$("#main_container").append(div);
						}else {
							$(a).append(p);
							$(div).append(title,a);
							$("#main_container").append(div);					
						}		            

					})				
			}});		
		};
		selectBook();
		listDiary();
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
		<div class="selectBook">
			<select class="btitle">
				<option value="">이동하고싶은 일기장을 선택하세요</option>
			</select>
		</div>
		<a href="insertDiary.do">
			<div class="insertForm">
				<span class="glyphicon glyphicon-plus gi-5x"></span>
			</div>
		</a>
	
		<div id="main">
			<div id="main_container">
				
			</div>
		</div>
			
	</div>
	
	
</div>

<!-- 푸터 -->
<br><br><br><br><br><br><br><br><br><br><br><br><br>
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


