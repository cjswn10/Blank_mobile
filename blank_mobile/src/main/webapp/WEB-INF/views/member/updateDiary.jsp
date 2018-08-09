<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>빈칸을 채우다.</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Do+Hyeon|Gaegu|Gamja+Flower|Jua|Nanum+Brush+Script|Nanum+Gothic+Coding|Nanum+Myeongjo|Nanum+Pen+Script|Source+Sans+Pro|Stylish|Sunflower:300" rel="stylesheet">

<link rel="stylesheet" href="../resources/css/blank.css?ver=1">
<script type="text/javascript" src="../resources/js/menu.js" ></script>
<script src="//code.jquery.com/jquery-3.2.1.js"></script>
<script type="text/javascript">
$(function() {
	var oldFont="${d.dfont}"
	var oldSecret=${d.secret}
	var oldDfile="${d.dfile}"
	var oldDphoto="${d.dphoto}"
	
	console.log(oldDfile);
	console.log(oldDphoto);
	
	//이전 폰트설정
	$("#dcontent").attr({
		style : "font-family:${d.dfont}; font-size:35px;",
	});
	$.each($("#dfont").find("option"), function(i, f) {
		if($(f).val() == oldFont) {
			$(this).attr({
				selected : "selected"
			})
		}
	});
	
	//이전 공개유무 설정
	$.each($(".secret"), function(i, s) {
		
		if($(s).val() == oldSecret) {
			$(this).attr({
				checked : "checked"
			})
		}
	});	
	
	//선택한 폰트 적용
	$("#dfont").change(function() {
		console.log($(this).val())
		$("#dcontent").attr({
			style : "font-family:"+$(this).val(),
			fontSize: "50px"
		})
		
		$("#dfont").attr({
			style : "font-family:"+$(this).val()
		})
	});
	
	//이전 그림이 있으면 보여주기
	if(oldDfile != "") {
		console.log("그림있따!!")
		$("#grim").attr({
			src : "../resources/upload2/" + oldDfile
		})
	}
	
	//이전 사진이 있으면 보여주기
	if(oldDphoto != "") {
		console.log("사진있따!!")
		$("#photo").attr({
			src : "../resources/upload/" + oldDphoto
		})
	}
	

});
// 그림판 띄어주는 창
var openG;

function openGrimpan() {
	
	var popupX = (window.screen.width / 2) - (600 / 2);
	// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음

	var popupY= (window.screen.height /2) - (680 / 2);
	// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
	
	window.name = "insertDiary";
	openG = window.open("grimpan.do","grimpan",'status=no, height=700, width=840, left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);
}



</script>

<script>
	var sel_file;
	var sel_fileG;
	

	<!-- 사진 보여주기 -->
	$(document).ready(function() {
		$("#upload").on("change", showImg)
	});
	
	function showImg(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f) {
			if(!f.type.match("image.*")) {
				alert("확장자 오류");
				return;
			}
			
			sel_file = f;
			var reader = new FileReader();
			reader.onload = function(e) {
				$("#photo").attr("src", e.target.result);
			}
			reader.readAsDataURL(f);
		});
	}
	
	<!-- 그림 보여주기 -->
	$(document).ready(function() {
		$("#uploadG").on("change", showImgG)
	});
	
	function showImgG(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f) {
			if(!f.type.match("image.*")) {
				alert("확장자 오류");
				return;
			}
			
			sel_fileG = f;
			var reader = new FileReader();
			reader.onload = function(e) {
				$("#grim").attr("src", e.target.result);
			}
			reader.readAsDataURL(f);
		});
	}
</script>
</head>
<body>

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
	<h2>일기 수정</h2>
	<hr>
	<form action="updateDiary.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="dno" id="dno" value="${d.dno}">

		<table>
			<tr>
				<td colspan="2">
					<label for="dtitle">제목 </label>
					<input type="text" name="dtitle" id="dtitle" required="required" value="${d.dtitle }">
				</td>
			</tr>
			
			<tr>
				<td>
					<label for="ddate">날짜</label>
					<input type="date" name="ddate" id="ddate" required="required" value="${d.ddate }">
				</td>
				<td>
					<label for="dweather">날씨</label>
					<input type="text" name="dweather" id="dweather" value="${d.dweather }">
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					<label for="dfont">글씨체</label>
					<select name="dfont" id="dfont">
						<option value="Nanum Brush Script" style="font-family: Nanum Brush Script" selected="selected" >Nanum Brush Script</option>
						<option value="Nanum Gothic Coding" style="font-family:Nanum Gothic Coding">Nanum Gothic Coding</option>
						<option value="Nanum Myeongjo" style="font-family:Nanum Myeongjo">Nanum Myeongjo</option>
						<option value="Nanum Pen Script" style="font-family:Nanum Pen Script">Nanum Pen Script</option>
						<option value="Stylish" style="font-family:Stylish">Stylish</option>
						<option value="Jua" style="font-family:Jua">Jua</option>
						<option value="Gamja Flower" style="font-family:Gamja Flower">Gamja Flower</option>
						<option value="Black Han Sans" style="font-family:Black Han Sans">Black Han Sans</option>
						<option value="Sunflower" style="font-family:Sunflower">Sunflower</option>
						<option value="Do Hyeon" style="font-family:Do Hyeon">Do Hyeon</option>
						<option value="Source Sans Pro" style="font-family:Source Sans Pro">Source Sans Pro</option>
						<option value="Gaegu" style="font-family:Gaegu">Gaegu</option>
					</select>
					<!-- 그림판 버튼 -->
					<button type="button" onclick="openGrimpan()"><img src="../resources/img/icon/pencil.png" alt="그리기" width="16px"></button>
	
					<label for="uploadG"><img alt="사진첨부" src="../resources/img/icon/draw.png" width="40px"></label>
					<input type="file" name="uploadG" id="uploadG" style="display: none;">
					
					<!-- 사진첨부 버튼 -->
					<label for="upload"><img alt="사진첨부" src="../resources/img/icon/picture.png" width="25px"></label>
					<input type="file" name="upload" id="upload" style="display: none;">
				</td>
			</tr>
			
			<!-- 그림, 사진 첨에 띄어주기-->
			<tr>
				<td colspan="2">
					<!-- 그림 -->
					<img id="grim" width="300">
					<br>
					<!-- 사진 -->
					<img width="300" id="photo">

					<br>
					<br>
					<!-- 글 -->
					<textarea rows="8" cols="40" name="dcontent" id="dcontent" style="font-family: ${d.dfont};">${d.dcontent }</textarea>
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					<input type="radio" name="secret" class="secret" value=1> 나만보기
					<input type="radio" name="secret" class="secret" value=0> 전체공개<br>
				</td>
			</tr>
			
		</table>
		<button type="submit">수정</button>
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