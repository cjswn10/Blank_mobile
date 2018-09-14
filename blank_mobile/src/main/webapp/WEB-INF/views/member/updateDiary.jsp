<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Do+Hyeon|Gaegu|Gamja+Flower|Jua|Nanum+Brush+Script|Nanum+Gothic+Coding|Nanum+Myeongjo|Nanum+Pen+Script|Source+Sans+Pro|Stylish|Sunflower:300" rel="stylesheet">

<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>

<link rel="stylesheet" href="../resources/css/blank.css?ver=5">
<script type="text/javascript" src="../resources/js/menu.js?ver=2" ></script>


<script src="//code.jquery.com/jquery-3.2.1.js"></script>
<script type="text/javascript" src="../resources/js/searchId.js?ver=8" ></script>
<style type="text/css">
table label {
	display: inline-block;
	width: 15%;
}


<style type="text/css">
#dcontent {
	width: 100%; 
	height: 50%;
}

.ui-page {
	background: #ffffff;
}

</style>


<script type="text/javascript">
$(function() {
	$(".today_weather").hide();
	
	if($("#cityName").val() == "")
	{
		$("#citya").html("현재 위치를 찾고 있습니다.")
	}
	
	setTimeout(function () {
		
		location.href = "logOut.do?id=${id}&autoOut=out";
		
	},10800*1000);	
	
	$.ajax({
		url:"http://ip-api.com/json",
		success:function(data)
		{
			var lat = data.lat
			var lon = data.lon
			var city = data.city
			
			if(city == "Seoul"){city = "서울";}
			else if(city == "Seoul-si"){city = "서울";}
			else if(city == "Incheon"){city = "인천";}
			else if(city == "Incheon-si"){city = "인천";}
			else if(city == "Suwon"){city = "수원";}
			else if(city == "Suwon-si"){city = "수원";}
			else if(city == "Chuncheon"){city = "춘천";}
			else if(city == "Chuncheon-si"){city = "춘천";}
			else if(city == "Gangneung"){city = "강릉";}
			else if(city == "Gangneung-si"){city = "강릉";}
			else if(city == "Cheongju"){city = "청주";}
			else if(city == "Cheongju-si"){city = "청주";}
			else if(city == "Daejeon"){city = "대전";}
			else if(city == "Daejeon-si"){city = "대전";}
			else if(city == "Hong Sung"){city = "홍성";}
			else if(city == "Hong Sung-si"){city = "홍성";}
			else if(city == "Seosan City"){city = "홍성";}
			else if(city == "Seosan City-si"){city = "홍성";}
			else if(city == "Jeonju"){city = "전주";}
			else if(city == "Jeonju-si"){city = "전주";}
			else if(city == "Daegu"){city = "대구";}
			else if(city == "Daegu-si"){city = "대구";}
			else if(city == "Ulsan"){city = "울산";}
			else if(city == "Ulsan-si"){city = "울산";}
			else if(city == "Pohang"){city = "포항";}
			else if(city == "Pohang-si"){city = "포항";}
			else if(city == "Busan"){city = "부산";}
			else if(city == "Busan-si"){city = "부산";}
			else if(city == "Gwangju"){city = "광주";}
			else if(city == "Gwangju-si"){city = "광주";}
			else if(city == "Mokpo"){city = "목포";}
			else if(city == "Mokpo-si"){city = "목포";}
			else if(city == "Jeju City"){city = "제주";}
			else if(city == "Jeju City-si"){city = "제주";}
			else if(city == "Changwon"){city = "창원";}
			else if(city == "Changwon-si"){city = "창원";}
			else if(city == "Yeosu"){city = "여수";}
			else if(city == "Yeosu-si"){city = "여수";}
			else if(city == "Baengnyeongdo"){city = "백령도";}
			else if(city == "Baengnyeongdo-si"){city = "백령도";}
			else if(city == "Dokdo"){city = "독도";}
			else if(city == "Dokdo-si"){city = "독도";}
			else if(city == "Uljin"){city = "울진";}
			else if(city == "Uljin-si"){city = "울진";}
			else if(city == "Andong"){city = "안동";}
			else if(city == "Andong-si"){city = "안동";}
			else if(city == "Heuksando"){city = "흑산도";}
			else if(city == "Heuksando-si"){city = "흑산도";}
			else
			{
				city = "서울";
			}
			$("#x").val(lat);
			$("#y").val(lon);
			$("#cityName").val(city);
			
			var y_day = $("#day").val()
			var y_month = y_day.substring(5,7)
			var y_date = y_day.substring(8,10)

			if(city != "")
			{
				setTimeout(function() {
					
					$("#citya").hide();
					$("#cityb").show();
					$("#cityb").html("현재 위치는 "+city+"이며, "+y_month+"월"+y_date+"일 날씨")
					
				}, 1000);
					
				
			}
			
		}
	})		
	
	var today = $("#today_date").val();
	var today_year = parseInt(today.substring(0,4));
	var today_month = parseInt(today.substring(5,6));
	var today_date = parseInt(today.substring(7,9));
	
	var todays = "";
	var arr2 = today.split("-");
	
	for(i=0;i<arr2.length;i++)
	{
		todays += arr2[i]
	}
	
	var today_now = parseInt(todays);
	
	var months = "";
	var year = "";
	var month = "";
	var select_day = "";
	var day = "";
	
	
	$("#ddate").change(function(){
		
		var ddate = $(this).val()
		
		year = parseInt(ddate.substring(0,4));
		month = ddate.substring(5,7);
		date_a = ddate.substring(8,10);
		
		
		var arr = ddate.split("-")
		
		for(i=0;i<arr.length;i++)
		{
			day += arr[i]
		}
		
		if(day.length > 8)
		{
			day = day.substring(8,day.length)
		}
		
		select_day = parseInt(day)
			
		months = parseInt(ddate.substring(5,7));
		
		$("#year").val(year)
		$("#month").val(month)
		
		if(ddate.charAt(8) == '0')
		{
			date = parseInt(ddate.charAt(9))
			$("#date").val(date)
		}
		else
		{
			date = parseInt(ddate.substring(8,10))
			$("#date").val(date)
		}
		
		$("#select_day").val(select_day);
		
		if($("#date").val() == '')
		{
			confirm("날짜를 입력 해주세요.")
		}
		else if($("#cityName").val() == '')
		{
			confirm("지역을 입력 해주세요.")
		}
		else if(select_day > today_now)
		{
			confirm("지난 날씨의 달력만 볼수 있습니다.")	
		}	
		else
		{
			$.ajax({
				url:"weather4.do",
				data:{"cityName":$("#cityName").val(),"dates":$("#date").val()},
				success:function(data)
				{
					
					var area = "";
					var cityName = $("#cityName").val();
					
					if(cityName == '서울'){area = "09680";}
					else if(cityName == '인천'){area = "11200";}
					else if(cityName == '수원'){area = "02111";}
					//else if(cityName == '파주'){area = "02480";}
					else if(cityName == '춘천'){area = "01110";}
					else if(cityName == '백령도'){area = "11720";}
					else if(cityName == '강릉'){area = "01150";}
					else if(cityName == '독도'){area = "04940";}
					//else if(cityName == '속초'){area = "01210";}
					else if(cityName == '청주'){area = "16111";}
					else if(cityName == '안동'){area = "04170";}
					else if(cityName == '대전'){area = "07110";}
					else if(cityName == '홍성'){area = "15800";}
					else if(cityName == '전주'){area = "13113";}
					else if(cityName == '대구'){area = "06290";}
					else if(cityName == '울산'){area = "10140";}
					else if(cityName == '포항'){area = "04111";}
					else if(cityName == '울진'){area = "04930";}
					else if(cityName == '부산'){area = "08710";}
					else if(cityName == '창원'){area = "03123";}
					else if(cityName == '광주'){area = "05200";}
					else if(cityName == '목포'){area = "12110";}
					else if(cityName == '여수'){area = "12130";}
					else if(cityName == '흑산도'){area = "12910";}
					else if(cityName == '제주'){area = "14100";}
					else
					{
						area = "09680";
					}
					
					$.ajax({url:"http://203.236.209.106:4997/weather.do/"+$("#year").val()+""+$("#month").val()+"/"+area+"",success:function(data){}})
					$.ajax({url:"http://203.236.209.106:4997/weather2.do",success:function(data){}})
					
					$("#cityb").hide();
					$("#cityc").show();
					$("#cityc").html("현재 위치는 "+cityName+"이며, "+month+"월"+date_a+"일 날씨")
					
					$("#weather").html(data);
					
					$("#tmef_img").show()
					
					select_day = $("#select_day").val();
					
					if(select_day == today_now)
					{
						$("#tmef_img").attr({"src":$("[name='img2'] > v").html()})
						$("#dweather").val($("[name='tmef2'] > v").html())
					}
					else if(select_day < today_now)
					{
						$("#tmef_img").attr({"src":$("[name='img'] > v").html()})
						$("#dweather").val($("[name='tmef'] > v").html())
					}	
					
				}
			})
		}
		
	})
	
	$("#weather").hide()	
	$("#weather2").hide()	
	
					var cityName = location.search.substr(1,1)
					
					if(cityName == '' || cityName == 'd')
					{
						$("#city").hide()
						
						var dweather = $("#tes").val();
						var dweathera = dweather.substring(dweather.indexOf("/")+1,dweather.length)
						var dweathers = dweather.substring(dweather.indexOf("/")+1,dweather.indexOf("/",dweather.indexOf("/")+1))
						
						if(dweathers == "")
						{
							dweathers = dweather
						}
						
						else if(dweathers.match("/") == "/")
						{
							dweathers = dweathera
						}
						
						
						if(dweathers == "맑음"){$("#tmef_img").attr({"src":"http://www.kma.go.kr/images/icon/NW/NB01.png"})}
						else if(dweathers == "구름조금"){$("#tmef_img").attr({"src":"http://www.kma.go.kr/images/icon/NW/NB02.png"})}
						else if(dweathers == "구름많음"){$("#tmef_img").attr({"src":"http://www.kma.go.kr/images/icon/NW/NB03.png"})}
						else if(dweathers == "흐림"){$("#tmef_img").attr({"src":"http://www.kma.go.kr/images/icon/NW/NB04.png"})}
						else if(dweathers == "비"){$("#tmef_img").attr({"src":"http://www.kma.go.kr/images/icon/NW/NB08.png"})}
						else if(dweathers == "소나기"){$("#tmef_img").attr({"src":"http://www.kma.go.kr/images/icon/NW/NB07.png"})}
						else if(dweathers == "흐리고 비"){$("#tmef_img").attr({"src":"http://www.kma.go.kr/images/icon/NW/NB08.png"})}
						else if(dweathers == "눈"){$("#tmef_img").attr({"src":"http://www.kma.go.kr/images/icon/NW/NB11.png"})}
						else if(dweathers == "비 또는 눈"){$("#tmef_img").attr({"src":"http://www.kma.go.kr/images/icon/NW/NB12.png"})}
						else if(dweathers == "눈 또는 비"){$("#tmef_img").attr({"src":"http://www.kma.go.kr/images/icon/NW/NB13.png"})}
						else if(dweathers == "안개"){$("#tmef_img").attr({"src":"https://ssl.pstatic.net/static/weather/images/w_icon/w_s9.gif"})}
						else if(dweathers == "천둥번개"){$("#tmef_img").attr({"src":"https://ssl.pstatic.net/static/weather/images/w_icon/w_s10.gif"})}
						else if(dweathers == "황사"){$("#tmef_img").attr({"src":"https://ssl.pstatic.net/static/weather/images/w_icon/w_s22.gif"})}
						else if(dweathers == "박무"){$("#tmef_img").attr({"src":"http://www.kma.go.kr/images/icon/NW/NB17.png"})}
						else if(dweathers == "연무"){$("#tmef_img").attr({"src":"http://www.kma.go.kr/images/icon/NW/NB18.png"})}
						else if(dweathers == "흐리고 가끔 비"){$("#tmef_img").attr({"src":"http://www.kma.go.kr/images/icon/NW/NB20.png"})}
						else if(dweathers == "흐리고 한때 비"){$("#tmef_img").attr({"src":"http://www.kma.go.kr/images/icon/NW/NB20.png"})}
						
					}
	
	$("#btnAdd").click(function(){
		if($("#dweather").val() == "")
		{
			var re = confirm("날씨를 입력해주세요.")
			if(re)
			{
				return false;
			}
			else
			{
				return false;
			}
		}
	})
	
	var oldFont="${d.dfont}"
	var oldSecret=${d.secret}
	var oldDfile="${d.dfile}"
	var oldDphoto="${d.dphoto}"
	
	console.log(oldFont);
	console.log(oldDfile);
	
	//이전 폰트설정
	$("#dcontent").attr({
		style : "font-family:${d.dfont};"
	});
	$.each($("#dfont").find("option"), function(i, f) {
		if($(f).val() == oldFont) {
			
			$(this).attr({
				selected : "selected"
			})
			
			//$(this).selectmenu('refresh');
		}
	});
	
	//이전 공개유무 설정
	$.each($(".secret"), function(i, s) {
		
		if($(s).val() == oldSecret) {
			$(this).attr("checked",true).checkboxradio("refresh");
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
		$("#grim").css({
			display: "inline-block"
		});
		
		$("#grim").attr({
			src : "../resources/upload2/" + oldDfile
		})
	}
	
	//이전 사진이 있으면 보여주기
	if(oldDphoto != "") {
		console.log("사진있따!!")
		$("#photo").css({
			display: "inline-block"
		});
		
		$("#photo").attr({
			src : "../resources/upload/" + oldDphoto
		})
	}
	
	$("#download").click(function() {
		var imgUrl = document.getElementById('canvas').toDataURL();
		var bno = ${d.bno}
		var dno = ${d.dno}
		
		/* 그림을 이미지파일로 서버에 저장하고 이름 가져오기*/
		$.ajax({
			url: "makeImgFile.do",
			data: { "imgbase64": imgUrl, "bno": bno, "dno": dno },
			success : function(data) {
				var grim = data + '.png';
				console.log(grim + "업데이트");
				$("#dfile").val(grim);
				
				if(oldDfile != "") {
					alert(oldDfile)
					console.log("이전파일 있음---------")
					showImgG();
				} else {
					$("#grim").attr({
						src : "../resources/upload2/" + grim
					});
					
					$("#grim").css({
						display: "inline-block"
					});
				}
				showDiary();
			}
		});
	});
});

// 그림판 보여주기
function showGrimpan() {
	$("#grimpan").css("display", "block");
	$("#insertDiaryDiv").css("display", "none");
	$(location).attr('href','#grimpan');
}

function showDiary() {
	$("#insertDiaryDiv").css("display", "block");
	$("#grimpan").css("display", "none");
	$(location).attr('href','#insertDiaryDiv');
}
</script>

<!-- 변경된 사진 & 그림 보여주기 -->
<script>
	var sel_file;
	
	$(document).ready(function() {
		$("#upload").on("change", showImg)
	});
	
	function showImg(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
	
		filesArr.forEach(function(f) {
			if (!f.type.match("image.*")) {
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
		
		$("#photo").css({
			display: "inline-block"
		});
	}
	
	function showImgG(){
		var myImage = document.getElementById("grim");
		myImage.src = canvas.toDataURL();
		
		$("#grim").css({
			display: "inline-block"
		});
		
		$("#grim").attr("src",myImage.src);
	}
</script>
</head>
<body>

<div id="insertDiaryDiv">
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
			<input type="text" name="id" id="id" placeholder="검색할 아이디를 입력하세요!" autocomplete="off" style="color:#818181; background-color:#000000; 

border: none;">
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

	<div class="content" style="width:100%;margin-bottom:30px;">

		<hr>
		<form action="updateDiary.do" method="post" enctype="multipart/form-data" data-ajax="false">
			<input type="hidden" name="dno" id="dno" value="${d.dno}">
	
			<table style="width:100%;">
				<tr>
					<td>
						<label for="dtitle">제목 </label>
						<input type="text" name="dtitle" id="dtitle" required="required" value="${d.dtitle }" style="width: 80%;">
					</td>
				</tr>
				
				<tr>
					<td>
						<label for="ddate">날&nbsp;&nbsp;&nbsp;짜</label>
						<input type="date" name="ddate" id="ddate" required="required" value="${d.ddate }" style="line-height: normal;width: 80%;">
					</td>
				</tr>
				<tr>
					<td>
						<label for="dweather">날&nbsp;&nbsp;&nbsp;씨</label>
						<input type="text" name="dweather" id="dweather" value="${d.dweather }" style="display:none;">
						<span id="citya"></span>
						<span id="cityb"></span>
						<span id="cityc"></span>
						<div class="status" style="display: inline-block;">
						<!--  <span id="city"></span> -->
						<img id="tmef_img" src="" width="30px" height="30px">
						<span id="tmef_info"></span>
						</div>
						<div class="today_weather" style="display: inline-block; width:65%">
							
						<input type="hidden" name="cityName" id="cityName">
						<input type="hidden" id="day" value="${d.ddate }">
						<input type="hidden" id="date">
						<input type="hidden" id="today_date" value="${todays }">
						<input type="hidden" id="year">
						<input type="hidden" id="month">
						<input type="hidden" id="tes" value="${d.dweather }">
						<input type="hidden" name="select_day" id="select_day">
            <input type="hidden" id="mno" name="mno" value="${mno }">  
						<span id="weather"></span>
						<span id="weather2"></span>
						<input type="hidden" id="x" name="latitude">
						<input type="hidden" id="y" name="longitude">
							
						</div>
					</td>
				</tr>
				
				<tr>
					<td>
						<select name="dfont" id="dfont" style="width:80%">
							<option value="Nanum Brush Script" style="font-family: Nanum Brush Script">Nanum Brush Script</option>
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
						
					</td>
				</tr>
				<tr>
					<td>
						<!-- 그림판 버튼 -->
						<a href="#" onclick="showGrimpan()" data-ajax="false"><button type="button" data-inline='true' data-ajax="false"><img src="../resources/img/icon/pencil.png" alt="그리기" width="16px">그림판</button></a>
						
						<!-- 그림첨부 버튼 -->
						<!-- <label for="uploadG"><img alt="사진첨부" src="../resources/img/icon/draw.png" width="40px"></label> -->
						<input type="hidden" name="dfile" id="dfile" style="display: none;">
						
						<!-- 사진첨부 버튼 -->
						<label for="upload" style="display:inline-block;"><img alt="사진첨부" src="../resources/img/icon/picture.png" width="40px"></label>
						<input type="file" name="upload" id="upload" style="display: none;">
					</td>
				</tr>
				
				<!-- 그림, 사진 첨에 띄어주기-->
				<tr>
					<td>
						<!-- 그림 -->
						<img id="grim" width="300" style="display: none;">
						<!-- 사진 -->
						<img id="photo" width="300" style="display: none;">
						<!-- 글 -->
						<textarea data-autogrow="false" class="form-control" rows="10" cols="30" name="dcontent" id="dcontent" style="font-family: ${d.dfont};">${d.dcontent }</textarea>
					</td>
				</tr>
				
				<tr>
					<td>
						<fieldset data-role="controlgroup" data-type="horizontal">
							<input type="radio" name="secret" class="secret" value=1 id="private"><label for="private">나만보기</label>
							<input type="radio" name="secret" class="secret" value=0 id="public"><label for="public">전체공개</label>
						</fieldset>
					</td>
				</tr>
				
				<tr>
					<td>
						<button id="btnAdd" type="submit">수정</button>
					</td>
				</tr>
			</table>
		</form>
		
	</div>
	
	<!-- 푸터 -->
	<footer class="footer" id="footer">
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
</div>	<!-- insertDiv -->

<div id="grimpan" style="display: none;">
	<div data-role="content" style="padding: 2px;margin-left: auto;margin-right: auto;">
		<div>
			<canvas id="canvas" width="400px" height="400px" style="display:inline-block;border: 1px black solid;max-width: 98vw;"></canvas>
		</div>
	<script type="text/javascript" src="../resources/js/drawingColor.js?ver=18"></script>
	
	<input type="hidden" id="selectColor">
	<input type="color" id="myColor" onchange="cg_color(this.value)">
	
	Size:<input type="range" min="1" max="5" id="Lwidth" value="1" onchange="cg_line(this.value)">

		<button data-inline='true' style='margin:0px auto;' id="delete"><img src="../resources/img/icon/newpage.png" width="15px"></button>
		<button data-inline='true' style='margin:0px auto;' id="prev"><img src="../resources/img/icon/prev.png" width="15px"></button>
		<a id="download"><button data-inline='true' style='margin:0px auto;' id="btnShowGrim"><img src="../resources/img/icon/download.png" width="15px"></button></a>
		<a href="#" onclick="showDiary()" data-ajax="false"><button data-inline='true' style='margin:0px auto;' id="btnOk"><img src="../resources/img/icon/exit.png" width="15px"></button></a>
	
	<img id="myImage">

	<script src="../resources/js/draw.js?ver=4"></script>

	</div>
</div>

</body>
</html>