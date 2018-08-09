<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.content{
	text-align: center;
}
#diary{
	font-size: 20px;
}

#diary_title{
	font-size: 30px;
	text-align: left;
	font-weight: 600;
}
	
</style>
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Do+Hyeon|Gaegu|Gamja+Flower|Jua|Nanum+Brush+Script|Nanum+Gothic+Coding|Nanum+Myeongjo|Nanum+Pen+Script|Source+Sans+Pro|Stylish|Sunflower:300" rel="stylesheet">

<title>빈칸을 채우다.</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">


<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<link rel="stylesheet" href="../resources/css/blank.css?ver=2">
<script type="text/javascript" src="../resources/js/menu.js" ></script>
<script type="text/javascript">
	$(function () {
		$('#delete').click(function() {
			re = confirm("정말 삭제하시겠습니다?");
			if (re == true) {
				location.href = "deleteDiary.do?dno="+${d.dno }
			}
			if (re == false) {
				location.href = "detailDiary.do?dno="+${d.dno}
			}
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

	
	<div class="content" style="margin-top: 100px">
		
		<div class="row">
		  <div class="col-md-2"></div>
		  <div class="col-md-1" id="diary_title">Title</div>
		  <div class="col-md-8 .col-md-offset-2" id="diary_title">${d.dtitle }</div>
		</div>
		<br>
		<div class="row">
		  <div class="col-md-2"></div>
		  <div class="col-md-2" id="diary" style="text-align:left;">Date:</div>
		  <div class="col-md-3" id="diary" style="text-align: left;">${d.ddate }</div>
		  <div class="col-md-2" id="diary" style="text-align: left;">Weather:</div>
		  <div class="col-md-3" id="diary" style="text-align: left;">${d.dweather }</div>
		</div>
		<br><br>
		
		<c:if test="${not empty d.dfile}">	
			<img width="500" height="500" src="../resources/upload2/${d.dfile }"><br>
		</c:if>
		<c:if test="${not empty d.dphoto}">	
			<img width="500" height="500" src="../resources/upload/${d.dphoto }"><br>
		</c:if>
		
		
		<textarea rows="10" cols="120" readonly="readonly" style="font-family: ${d.dfont}">${d.dcontent}</textarea> <br>
		<hr>
		
		<a href="updateDiary.do?dno=${d.dno }"><button>수정</button></a>
		<button id="delete"><a herf="#">삭제</a></button>
		<hr>
		<a href="diary.do?mno=${mno }&bno=${bno}">일기 목록</a>
		<hr>
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
