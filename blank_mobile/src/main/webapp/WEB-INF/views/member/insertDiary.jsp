<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport"
		content="width=device-width,
		initial-scale=1.0,
		maximum-scale=1.0,
		minimum-scale=1.0,
		user-scalable=no">
		
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<!-- 웹폰트 -->
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Do+Hyeon|Gaegu|Gamja+Flower|Jua|Nanum+Brush+Script|Nanum+Gothic+Coding|Nanum+Myeongjo|Nanum+Pen+Script|Source+Sans+Pro|Stylish|Sunflower:300" rel="stylesheet">
<link rel="stylesheet" href="../resources/css/blank.css">
<script type="text/javascript" src="../resources/js/menu.js" ></script>

<style type="text/css">
	.today_weather
	{
		position: relative;
		top: -450px;
		width:400px;
		left: 650px;
	}
	.city_weather
	{
		position: relative;
		left: 120px;
		
	}
	#citySelect
	{
		width: 70px;
		height: 26px;
	}
	#today
	{
		font-size: 20px;
		position: relative;
		left: 40px;
	}
	#location
	{
		font-size: 10px;
		position: relative;
		left: 30px;
	}
	#tmef_img
	{
		position: relative;
		left: 30px;
	}
	#test > li
	{
		list-style: none;
	}
	#weather_icon
	{
		position: relative;
		top: 30px;
		left: 0px;
	}
	.status
	{
		position: relative;
		font-size:20px;
		left: 120px;
	}

</style>

<script type="text/javascript">
$(function() {
	
	setTimeout(function () {
		
		location.href = "logOut.do?id=${id}&autoOut=out";
		
	},10800*1000);
	
	$("#weather").hide()	
	
	var cityName = location.search.substr(1,1)
	
	if(cityName == '' || cityName == 'd')
	{
		$("#tmef_img").hide()
		$("#city").hide()
		$("#dweather").val("")
	}	
	else if($("[name='tmef'] > v").html().substring(1,2) == 's')
	{
		$("#tmef_img").show()
		$("#dweather").val($("[name='tmef2'] > v").html())
		$("#city").html($("#citys").val()+"의 날씨")
	}	
	else
	{
		$("#tmef_img").show()
		$("#dweather").val($("[name='tmef'] > v").html())
		$("#city").html($("#citys").val()+"의 날씨")
		
	}		
	
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
		
		var arr = ddate.split("-")
		
		for(i=0;i<arr.length;i++)
		{
			day += arr[i]
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
			
		
	})

	var area = "";
	var cityName = $("#citys").val();
	
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
	
	$.ajax({url:"http://203.236.209.112:4997/weather.do/"+$("#year").val()+""+$("#month").val()+"/"+area+"",success:function(data){}})
	
	$.ajax({url:"http://203.236.209.112:4997/weather2.do",success:function(data){}})
	
	$("#tmef_img").attr({"src":$("[name='img'] > v").html()})
	
	$("#search").click(function() {	
		
		
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
			var re = confirm("지난 날씨의 달력만 볼수 있습니다.")
			if(re)
			{
				location.href="insertDiary.do?dtitle="+$("#dtitle").val()+"&dcontent="+$("#dcontent").val()
				
			}	
			else
			{
				location.href="insertDiary.do?dtitle="+$("#dtitle").val()+"&dcontent="+$("#dcontent").val()
				
			}	
		}
		else if(select_day == today_now)
		{
			location.href="insertDiary.do?cityName="+$("#cityName").val()+"&dtitle="+$("#dtitle").val()
			+"&ddate="+$("#ddate").val()+"&dcontent="+$("#dcontent").val()+"&date="+$("#date").val()
			+"&year="+$("#year").val()+"&month="+$("#month").val();
		}
		else
		{
			location.href="insertDiary.do?cityName="+$("#cityName").val()+"&dtitle="+$("#dtitle").val()
			+"&ddate="+$("#ddate").val()+"&dcontent="+$("#dcontent").val()+"&date="+$("#date").val()
			+"&year="+$("#year").val()+"&month="+$("#month").val();
		}
		
	})
	
	$("#citySelect").change(function(){
		
		$("#cityName").val($("#citySelect").val())
	
	})
	
	//선택한 폰트 dfont, dcontent에 적용
	$("#dfont").change(function() {
		console.log($(this).val())
		$("#dcontent").attr({
			style : "font-family:"+$(this).val()
		})
		
		$("#dfont").attr({
			style : "font-family:"+$(this).val()
		})
	});
});

var openG;

function openGrimpan() {
	
	var popupX = (window.screen.width / 2) - (600 / 2);
	// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음

	var popupY= (window.screen.height /2) - (680 / 2);
	// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
	
	window.name = "insertDiary";
	openG = window.open("grimpan.do","grimpan",'status=no, height=600px, width=600px, left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);
}

</script>

<title>빈칸을 채우다.</title>

<!-- 사진 보여주기 -->
<script>
	var sel_file;
	var sel_fileG;
	

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
	}
	
	$(document).ready(function() {
		$("#uploadG").on("change", showImgG)
	});

	function showImgG(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);

		filesArr.forEach(function(f) {
			if (!f.type.match("image.*")) {
				alert("확장자 오류");
				return;
			}

			sel_fileG = f;
			var reader = new FileReader();
			reader.onload = function(e) {
				$("#img").attr("src", e.target.result);
			}
			reader.readAsDataURL(f);
		});
	}
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

	
	<div class="content" style="margin-top: 100px">
		<h2>빈칸을 채우다</h2>
		<hr>
	 
		<form action="insertDiary.do" method="post" enctype="multipart/form-data">
		
			<input type="hidden" name="bno" id="bno" value="${bno }"><br> 
			<input type="hidden" name="mno" id="mno" value="${mno }"><br> 
			

			<table>
				<tr>
					<td colspan="2">
						<label for="dtitle">제목 </label>
						<input type="text" name="dtitle" id="dtitle" required="required" value="${dtitle }">
					</td>
				</tr>
				
				<tr>
					<td>
						<label for="ddate">날짜</label>
						<input type="date" name="ddate" id="ddate" value="${ddate }" required="required">
					</td>
					<td>
						<label for="dweather">날씨</label>
						<input type="text" name="dweather" id="dweather">
					</td>
				</tr>
				
				<tr>
					<td colspan="2">
						<label for="dfont">글씨체</label>
						<select name="dfont" id="dfont">
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
						<!-- 그림판 버튼 -->
						<button type="button" onclick="openGrimpan()"><img src="../resources/img/icon/pencil.png" alt="그리기" width="16px">그림판</button>
						
						<label for="uploadG"><img alt="그림첨부" src="../resources/img/icon/draw.png" width="40px">(그림첨부)</label>
						<input type="file" name="uploadG" id="uploadG" style="display: none;">
						
						<!-- 사진첨부 버튼 -->
						<label for="upload"><img alt="사진첨부" src="../resources/img/icon/picture.png" width="40px">(사진첨부)</label>
						<input type="file" name="upload" id="upload" style="display: none;">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<!-- 그림 -->
						<img id="img" width="300">
						<br>
						<!-- 사진 -->
						<img id="photo" width="300">
						<!-- 글 -->
						<textarea class="form-control" rows="10" name="dcontent" id="dcontent" style="font-family: Nanum Brush Script">${dcontent }</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="radio" name="secret" value=1>나만보기
						<input type="radio" name="secret" value=0 checked="checked">전체공개
					</td>
				</tr>
				<tr>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td>
						<button type="submit">등록</button>
					</td>
				</tr>
			</table>
			
			<div class="today_weather">
				<ul id="test">
					<img id="weather_icon" src="../resources/img/weather.png" width="30" height="30">
					<li id="today">날씨가 궁금하신가요?</li>
					<li id="location">지역과 날씨를 선택 후 검색버튼을 눌러주세요.</li>
				</ul>
				<br>
				<div class="city_weather">
					<select id="citySelect">
							<option>지역</option>
							<option>서울</option>
							<option>인천</option>
							<option>수원</option>
							<option>파주</option>
							<option>춘천</option>
							<option>백령도</option>
							<option>강릉</option>
							<option>속초</option>
							<option>청주</option>
							<option>안동</option>
							<option>대전</option>
							<option>홍성</option>
							<option>전주</option>
							<option>대구</option>
							<option>울산</option>
							<option>포항</option>
							<option>부산</option>
							<option>창원</option>
							<option>광주</option>
							<option>목포</option>
							<option>여수</option>
							<option>흑산도</option>
							<option>제주</option>
						</select>
						<input type="hidden" name="cityName" id="cityName">
						<input type="hidden" id="citys" value="${cityName }">
						<input type="hidden" id="day" value="${ddate }">
						<input type="hidden" name="date" id="date" value="${date }">
						<input type="hidden" id="today_date" value="${todays }">
						<input type="hidden" name="year" id="year" value="${year }">
						<input type="hidden" name="month" id="month" value="${month }">
						<span id="weather"> ${weather } </span>
						<button id="search" type="button">검색</button>
				</div>
				<br><br>
				<div class="status">
					<span id="city"></span><br><br>
					<img id="tmef_img" src="" width="60" height="60">
				</div>
			</div>
			
		</form>
		
	</div>
</div>
</body>
</html>