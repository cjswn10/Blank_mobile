<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Do+Hyeon|Gaegu|Gamja+Flower|Jua|Nanum+Brush+Script|Nanum+Gothic+Coding|Nanum+Myeongjo|Nanum+Pen+Script|Source+Sans+Pro|Stylish|Sunflower:300" rel="stylesheet">

<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

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

.insertDiary{
	background-color: pink;
	padding: 15px;	
	opacity: 0.8;
}

#diaryImg{
	width: 100%;
	height: 100%;
}

.ddate{	
	text-align: right;	
}

.listdiary{
	width: 100%;
	height: 100%;
}
.selectBook
{
	width: 400px;
	margin: 0 auto;
	text-align: left;
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
		width: 20%;
		float: left;
		margin: 50px;
		padding: 10px;
		font-size: 15px;
	}
	
	.dcontent{
		border: 1px solid black;
		border-radius: 10px;
		width: 50%;
		height: 100%;		
		/* width: 353px;
		height: 250px; */
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
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../resources/css/blank.css?ver=1">
<script type="text/javascript" src="../resources/js/menu.js" ></script>
<script type="text/javascript">
	 $(function () {
		
		setTimeout(function () {
			
			location.href = "logOut.do?id=${id}&autoOut=out";
			
		},10800*1000);
		
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
					$.each(list, function(idx, d) {
						var li = $('<li></li>');
						$(li).attr("idx",idx);
						var a = $('<a href="#detailDiary"></a>');
						
						$(li).click(function() {							
							var i = $(this).attr("idx");							
							var selG = list[i];							
							 
							$('#diaryImg').attr("src", "../resources/upload2/"+ selG.dfile);							
							$('#ddate').html(selG.ddate);
							$('#dweather').html(selG.dweather);
							$('#dtitle').html(selG.dtitle);
							$('#dcontent').html(selG.dcontent);
						})
						
						/* var img = $('<img></img>').attr({
							src: "../resources/upload2/" + d.dfile,
							width: "100",
							height: "100"
						}) */
						
						
						var title = $('<span></span>').html(d.dtitle);
						var content = $('<p></p>').html(d.dcontent);				
						var ddate = $('<p class="ddate" style="font-size: 8px;"></p>').html(d.ddate);
						
						if (d.dphoto != null) {							
							var img = $('<img></img>').attr({
								src: "../resources/upload/" + d.dphoto,
								width: "100%",
								height: "100%"					
							});
							$(a).append(img, title, content, ddate);
							$(li).append(a);
							$('#list').append(li);
						}else {
							$(a).append(title, content, ddate);
							$(li).append(a);
							$('#list').append(li);					
						}		            
						
						if (d.dfile != null) {							
							var img = $('<img></img>').attr({
								src: "../resources/upload2/" + d.dfile,
								width: "100%",
								height: "100%"					
							});
							$(a).append(img, title, content, ddate);
							$(li).append(a);
							$('#list').append(li);
						}else {
							$(a).append(title, content, ddate);
							$(li).append(a);
							$('#list').append(li);					
						}						
						/* $(a).append(img, title, content, ddate);
						$(li).append(a);
						$('#list').append(li); */	
						
						/* //날짜 날씨 제목 그림 사진 글
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
								width: "50%",
								height: "50%"					
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
								width: "50%",
								height: "50%"					
							});
							$(a).append(img);
							$(div).append(title,a,br,p);
							$("#main_container").append(div);
						}else {
							$(a).append(p);
							$(div).append(title,a);
							$("#main_container").append(div);					
						}		            
 */
					})
					$('#list').listview("refresh");
			}});		
		};
		selectBook();
		listDiary();
	});
	 
</script>
</head>
<body>
	<div data-role="page">
		<div data-role="header">헤더</div>
				
		<div data-role="content">
			<ul data-role="listview" id="list"></ul>			
		</div>
			
		<div data-role="footer" data-position="fixed">
			<div onclick="location.href='insertDiary.do'" class="insertDiary" style="position:fixed; right: 0; bottom: 0; cursor: pointer;">일기 등록</div>
		
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
	
	<div data-role="page" id="detailDiary">
		<div data-role="header">헤더</div>
				
		<div data-role="content">
			<img id="diaryImg">
			<span id="ddate" style="font-size: 12px;"></span>
			<span id="dweather" style="font-size: 12px;"></span>
			<p id="dtitle" style="font-size: 20px;"></p>
			<p id="dcontent" style="font-size: 15px;"></p>			
		</div>
			
		<div data-role="footer" data-position="fixed">
			<font color="white"><span onclick="location.href='updateDiary.do'" class="updateDiary" style="position:fixed; right: 92px; bottom: 0; cursor: pointer;">일기 수정</span></font>
			<font color="white"><span onclick="location.href='deleteDiary.do'" class="deleteDiary" style="position:fixed; right: 0px; bottom: 0; cursor: pointer;">일기 삭제</span></font>
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


