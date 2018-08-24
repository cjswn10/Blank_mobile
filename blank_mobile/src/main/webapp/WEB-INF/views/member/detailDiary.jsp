<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<style type="text/css">

span{
	margin-right: 10px;
}

#diaryImg{
	width: 100%;
	height: 100%;
}

.deleteDiary{
	background-color: orange;
	padding: 15px;	
	opacity: 0.8;	
}

.updateDiary{
	background-color: blue;
	padding: 15px;	
	opacity: 0.8;
}

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
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../resources/css/blank.css?ver=2">
<script type="text/javascript" src="../resources/js/menu.js" ></script>
<script type="text/javascript">
	$(function () {		
		if ("${d.dfile}" !== "") {
			var img = $('<img></img>').attr({
				src: "../resources/upload2/${d.dfile}",
				width: "100%",
				height: "100%"
			})
			$('#detailDiary').append(img);	
			
		}
		if ("${d.dphoto}" !== "") {
			var img = $('<img></img>').attr({
				src: "../resources/upload/${d.dphoto}",
				width: "100%",
				height: "100%"
			})
			$('#detailDiary').append(img);			
		}
		
		var ddate = $('<span style="font-size: 12px;"></span>').html("${d.ddate}")
		var dweather = $('<span style="font-size: 12px;"></span>').html("${d.dweather}")
		var dtitle = $('<p style="font-size: 20px;"></p>').html("${d.dtitle}")
		var dcontent = $('<p style="font-size: 15px;"></p>').html("${d.dcontent}")
		$('#detailDiary').append(ddate, dweather, dtitle, dcontent);					
		
		setTimeout(function () {
			
			location.href = "logOut.do?id=${id}&autoOut=out";
			
		},10800*1000);
		
		$('.deleteDiary').click(function() {
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

	<div data-role="page">
		<div data-role="header">헤더</div>
				
		<div data-role="content" id="detailDiary">
					
		</div>
			
		<div data-role="footer" data-position="fixed">
			<font color="white"><span onclick="location.href='updateDiary.do?dno=${d.dno}'" class="updateDiary" style="position:fixed; right: 92px; bottom: 0; cursor: pointer;">일기 수정</span></font>
			<font color="white"><span onclick="location.href='deleteDiary.do?dno=${d.dno}'" class="deleteDiary" style="position:fixed; right: 0px; bottom: 0; cursor: pointer;">일기 삭제</span></font>
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
		</div>
	</div>
</body>
</html>
