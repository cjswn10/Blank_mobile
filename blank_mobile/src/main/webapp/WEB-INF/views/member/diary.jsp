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

/*insert 아이콘*/
.gi-5x{
	font-size: 50px;
	position: relative;
}
.iljung-div{
    display:flex;
    flex-direction:row;
    justify-content : space-around;
    width:100%;

}

.iljung-date-div .btn{
    border:1px solid #EFE7E6;
    background-color: #EFE7E6;
    color:#662408;
    font-family: 'Nanum Pen Script', serif;
}


</style>
<title>빈칸을 채우다.</title>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
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
		
		var mykeyword = function()
		{
			 $.ajax({
					url:"myKeyword.do",
					data:{"bno":bno,"mno":mno},
					success:function(data)
					{
						$("#keyword").html(data);
						$("#keyword").hide();
						$("#hash").html("#"+$("[name='data7'] > v").html()+"   #"+$("[name='data8'] > v").html()+"   #"+$("[name='data9'] > v").html())
							
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
						var li = $('<li data-icon="false"></li>');
						$(li).attr("idx",idx);									
						var a = $('<a data-ajax="false" href=detailDiary.do?dno='+d.dno+'></a>');	
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
					})
					$('#list').listview("refresh");
			}});		
		};
		selectBook();
		listDiary();
		mykeyword();
	});
	 
</script>
</head>
<body>	
	<div data-role="page">
				
	<div data-role="content" style="padding: 0">
		<!-- side-menu -->
		<section id="mySidenav" class="sidenav">
			<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
			<a href="#"><img class="side_icon" src="../resources/img/icon/person.png">${id }님</a>
			<h5>회원정보</h5>
			<a data-ajax="false" href="pwdCheck.do?id=${id }">Edit</a>
			<a data-ajax="false" href="logOut.do?id=${id }">logout</a>
			<br>
			<h5>고객센터</h5>
			<a href="qNa.do" data-ajax="false">Contact</a>
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
			<nav class="clearfix" style="margin-bottom: 20px">
				<span id="menu" style="cursor:pointer;" onclick="openMenu()" class="glyphicon glyphicon-menu-hamburger"> </span>
			    <a data-ajax="false" href="main.do"><img src="../resources/img/blank.png" class="logo"></a>
			    <span style="cursor:pointer;" onclick="openNav()" class="glyphicon glyphicon-user"> </span>
			    
			    <ul id="main_menu">
			        <li><a href="book.do" data-ajax="false">DIARY</a></li>
			        <li><a href="favorite.do" data-ajax="false">FAVORITES</a></li>
			        <li style="border: none"><a href="myPage.do" data-ajax="false">MYPAGE</a></li>
			    </ul>
			</nav>

			
			<!----------- 내용 -------------->		
			<div>
				<span id="keyword"></span>
				<div class="iljung-div">
                    <div class="iljung-date-div"><p class="btn btn1" rel="div2"><span id="hash">많이 쓰는 단어 분석중...</span></p></div>
                    
        		</div>
				
			</div>
			<ul data-role="listview" id="list" style="padding: 15px;"></ul>	
			
			
			<!--------- 푸터 ---------->
			<div class="footer">
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
	</div>
			
		<div data-role="footer" data-position="fixed">
			<div onclick="location.href='insertDiary.do'" class="insertDiary" style="position:fixed; right: 0; bottom: 0; cursor: pointer;">일기 등록</div>
		</div>
	</div>			
</body>
</html>


