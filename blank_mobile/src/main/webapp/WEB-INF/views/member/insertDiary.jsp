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

<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<!-- 웹폰트 -->
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Do+Hyeon|Gaegu|Gamja+Flower|Jua|Nanum+Brush+Script|Nanum+Gothic+Coding|Nanum+Myeongjo|Nanum+Pen+Script|Source+Sans+Pro|Stylish|Sunflower:300" rel="stylesheet">
<link rel="stylesheet" href="../resources/css/blank.css">
<script type="text/javascript" src="../resources/js/menu.js" ></script>
<script type="text/javascript" src="../resources/js/searchId.js" ></script>
<style type="text/css">

table label {
	display: inline-block;
	width: 15%;
}
</style>

<script type="text/javascript">
$(function() {
	
	setTimeout(function () {
		
		location.href = "logOut.do?id=${id}&autoOut=out";
		
	},10800*1000);

	$("#weather").hide()	
	$("#tmef_img").hide()
	/*
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
		$("#img").css({
			display: "inline-block"
		});
		
		$("#img").attr("src", $("#img_a").html());
	}	
	else
	{
		$("#tmef_img").show()
		$("#dweather").val($("[name='tmef'] > v").html())
		$("#city").html($("#citys").val()+"의 날씨")
		$("#img").css({
			display: "inline-block"
		});
		
		$("#img").attr("src", $("#img_a").html());
	}		
	*/
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
		
		var ddate = $(this).val();
		
		year = parseInt(ddate.substring(0,4));
		month = ddate.substring(5,7);
		
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
			
	})
	
		$("#citySelect").change(function(){
		
		$("#cityName").val($("#citySelect").val())
	
	})
	
	$("#search").click(function() {	
		
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
					
					$.ajax({url:"http://203.236.209.112:4997/weather.do/"+$("#year").val()+""+$("#month").val()+"/"+area+"",success:function(data){}})
					
					$.ajax({url:"http://203.236.209.112:4997/weather2.do",success:function(data){}})
					
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
	
	
	$("#download").click(function() {
		//downloadCanvas(this, 'canvas', 'myGrim.png');
		var imgUrl = document.getElementById('canvas').toDataURL();
		
		$.ajax({
			  url: "makeImgFile.do",
			  data: { "imgbase64": imgUrl },
			  success : function() {
				  alert('선택영역을 서버의 이미지 파일에 저장했습니다');
			  }
		});
		
	});

	$("#btnOk").click(function() {

		var myImage = document.getElementById("myImage");
		myImage.src = canvas.toDataURL();

		self.close();
	});
	
	//$("#insertDiaryDiv").find("*").attr("data-enhance", "false");
	
});

/*
//C:\Blank\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Blank\resources\upload2
// 작업 이미지 로컬 다운로드(.PNG)
function downloadCanvas(link, canvasId, filename) {
	link.href = document.getElementById(canvasId).toDataURL();
	link.download = filename;
}
*/
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

<title>빈칸을 채우다.</title>

<!-- 사진 보여주기 -->
<script>
	var sel_fileG;
	
	<!-- 그림 보여주기 -->
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
				$("#img").css({
					display: "inline-block"
				});
				
				$("#img").attr("src", e.target.result);
				
			}
			reader.readAsDataURL(f);
		});
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

	
	<div class="content" style="width:100%;">
		<hr>
	 
		<form action="insertDiary.do" method="post" enctype="multipart/form-data" style="width:95%; margin-left: auto; margin-right: auto;">
			<input type="hidden" name="bno" id="bno" value="${bno }"> 
			<input type="hidden" name="mno" id="mno" value="${mno }">

			<table style="width:100%;">
				<tr>
					<td>
						<label for="dtitle">제&nbsp;&nbsp;&nbsp;목 </label>
						<input type="text" name="dtitle" id="dtitle" required="required" value="${dtitle }" style="width: 80%;">
					</td>
				</tr>
				
				<tr>
					<td>
						<label for="ddate">날&nbsp;&nbsp;&nbsp;짜</label>
						<input type="date" name="ddate" id="ddate" value="${ddate }" required="required" style="line-height: normal;width: 80%;">
					</td>
				</tr>
				<tr>
					<td>
						<label for="dweather">날&nbsp;&nbsp;&nbsp;씨</label>
						<input type="text" name="dweather" id="dweather" style="display:none;">
						
						<div class="today_weather" style="display: inline-block; width:65%"">
						<!-- 
						<ul id="test">
							<img id="weather_icon" src="../resources/img/weather.png" width="30" height="30">
							<li id="today">날씨가 궁금하신가요?</li>
							<li id="location">지역과 날씨를 선택 후 검색버튼을 눌러주세요.</li>
						</ul>
						 -->
						<div class="city_weather">
							<select id="citySelect" style="width:70%">
									<option>지역</option>
									<option>서울</option>
									<option>인천</option>
									<option>수원</option>
									<option>독도</option>
									<option>춘천</option>
									<option>백령도</option>
									<option>강릉</option>
									<option>울진</option>
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
								<input type="hidden" name="cityName" id="cityName" >
								<input type="hidden" id="day">
								<input type="hidden" name="date" id="date">
								<input type="hidden" id="today_date" value="${todays }">
								<input type="hidden" name="year" id="year">
								<input type="hidden" name="month" id="month">
								<input type="hidden" name="select_day" id="select_day">
								<span id="weather"> ${weather } </span>
								<button id="search" type="button">검색</button>
						</div>
						
						
					</div>
			
					<div class="status" style="display: inline-block;">
						<!--  <span id="city"></span> -->
						<img id="tmef_img" src="" width="30px" height="30px">
						<span id="tmef_info"></span>
					</div>
						
						
					</td>
				</tr>
				<tr>
					<td>
						<label for="dfont">글씨체</label>
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
						<!-- <button type="button" style="display: inline-block;" onclick="openGrimpan()"><img src="../resources/img/icon/pencil.png" alt="그리기" width="16px">그림판</button> -->
						<a href="#" onclick="showGrimpan()" data-ajax="false"><button type="button" style="display: inline-block;"><img src="../resources/img/icon/pencil.png" alt="그리기" width="16px">그림판</button></a>
						
						<label for="uploadG"><img alt="그림첨부" src="../resources/img/icon/draw.png" width="40px"></label>
						<input type="file" name="uploadG" id="uploadG" style="display: none;">
						
						<!-- 사진첨부 버튼 -> 그림판 버튼으로 통합-->
						<!-- <label for="upload"><img alt="사진첨부" src="../resources/img/icon/picture.png" width="40px"></label> -->
						<input type="file" name="upload" id="upload" style="display: none;">
					</td>
				</tr>
						
				<tr>
					<td>
						<!-- 그림 -->
						<img id="img" width="300" style="display: none">
						<!-- 글 -->
						<textarea class="form-control" rows="8" name="dcontent" id="dcontent" style="font-family: Nanum Brush Script; width:100%; height:50%;">${dcontent }</textarea>
					</td>
				</tr>
				<tr>
					<td>
						<input type="radio" name="secret" value=1 id="private"><label for="private">나만보기</label>
						<input type="radio" name="secret" value=0 checked="checked" id="public"><label for="public">전체보기</label>
					</td>
				</tr>
				<tr>
					<td>
						<button id="btnAdd" type="submit">등록</button>
					</td>
				</tr>
			</table>
			
			
			
		</form>
		
	</div>
</div>
</div>


<div id="grimpan" style="display: none;">
	<div data-role="content">
		<div>
			<canvas id="canvas" width="400px" height="400px" style="display:inline-block;border: 1px black solid;"></canvas>
		</div>
	<script type="text/javascript" src="../resources/js/drawingColor.js?ver=18"></script>
	
	<input type="hidden" id="selectColor">
	<input type="color" id="myColor" onchange="cg_color(this.value)">
	
	Size:<input type="range" min="1" max="5" id="Lwidth" value="1" onchange="cg_line(this.value)">

		<button data-inline='true' style='margin:0px auto;' id="delete"><img src="../resources/img/icon/newpage.png" width="15px"></button>
		<button data-inline='true' style='margin:0px auto;' id="prev"><img src="../resources/img/icon/prev.png" width="15px"></button>
		<a id="download"><button data-inline='true' style='margin:0px auto;'><img src="../resources/img/icon/download.png" width="15px"></button></a>
		<a href="#" onclick="showDiary()" data-ajax="false"><button data-inline='true' style='margin:0px auto;' id="btnOk"><img src="../resources/img/icon/exit.png" width="15px"></button></a>
	
	
	<img id="myImage">

	<script src="../resources/js/draw.js?ver=4"></script>

	</div>
</div>



</body>
</html>