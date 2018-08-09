<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>빈칸을 채우다.</title>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

	
	/* 새일기장 만들기 */
	.insertBook
	{
		
		border: 1px solid black;
		width: 960px;
		margin: 0 auto;
		text-align: center;

	}

	/* remove 아이콘위치 */
	#remove_location
	{
		position: relative;
		left: 302px;
		top: -90px;
	}

	/* plus 아이콘 */
	.glyphicon-plus
	{
		font-size: 50px;
		
	}
	/* remove 아이콘 */
	.glyphicon-remove
	{
		font-size: 250%;
		
	}
	/* 일기장 목록 컨테이너 */
	#main_container
	{
		width: 960px;
		margin: 0 auto;
	}
	
	#main
	{
		overflow: hidden;
	}
	
	/* 서브컨테이너의 자식 div들 */
	#main_container > div
	{
		position:relative;
		width: 350px;
		height: 400px;
		float: left;
		margin: 50px;
		padding: 30px;
		background-color: pink;
	}
	/* 일기장 제목 */
	.btitle
	{
		font-family: 'Nanum Pen Script', serif;
		position:relative;
		display:table;
		font-size: 30px;
		color:black;
		top:30px;
		margin-left: auto;
		margin-right: auto;
		background-color: white;
		width: 200px;
		height: 30px;
		text-align: center;
		
	}
	/*일기장 수정*/
	.update
	{
		font-family: 'Nanum Pen Script', serif;
		position:relative;
		display:table;
		font-size: 25px;
		color:black;
		top:295px;
		left: 90px;

	}
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<link rel="stylesheet" href="../resources/css/blank.css">
<script type="text/javascript" src="../resources/js/menu.js" ></script>
<script type="text/javascript">

	$(function() {
		var mno = ${mno}
		
		//일기장 목록 불러오기위한 기능 
		var listBook = function() {
					
			$.ajax({
				url:"listBook.do",
				data:{"mno":mno},
				success:function(data)
				{
					var list = eval("("+data+")");
					$.each(list,function(i,d){
						
						//일기장 목록 div
						var div = $("<div></div>");
						
						
						//일기장 -->> 일기목록
						var aList = $("<a class='btitle' href='diary.do?mno="+d.mno+"&bno="+d.bno+"'></a>")
						
						//일기장 제목
						var title = $("<span ></span>").html(d.btitle);
						
						//일기장수정 문구
						var Update = $("<button></button>").html("일기장 수정")
						
						//일기장 수정a태그
						var aUpdate = $("<a class='update' href='updateBook.do?bno="+d.bno+"'></a>")
						
						//일기장 삭제a태그
						var aRemove = $("<a id='remove_location'></a>")
						
						
						//remove 아이콘을 누르면 발생하여 선택한 일기장 삭제
						$(aRemove).click(function() {
							re = confirm('삭제된 그림일기장은 복구할 수 없습니다.\n정말로 삭제 하시겠습니까?');
							if(re == true)
							{
								console.log("일기장이 정상적으로 삭제되었습니다. ")
								location.href="deleteBook.do?bno="+d.bno;
							}	
							else
							{
								return;
							}	
						})
						
						//일기장 삭제 아이콘
						var remove = $("<span class='glyphicon glyphicon-remove'></span>")
						
						//일기장 색상
						var color = $(div).attr({
							style:"background-color:"+d.bcolor
						})
						
						//일기장 수정a태그에 수정하기 문구 추가
						$(aUpdate).append(Update)
						
						//일기장 삭제a태그에 삭제아이콘 추가
						$(aRemove).append(remove)
						
						//일기장 목록 --> 일기목록
						$(aList).append(title)
						
						//일기장 목록에 제목,삭제a태그 추가
						$(div).append(aList,aRemove,color,aUpdate)

						
						//일기장 서브컨테이너에 추가
						$("#main_container").append(div)
					});
				}
			});
		}
		//일기장 목록 불러오기
		listBook();
		
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
	    <span style="cursor:pointer" onclick="openNav()" class="glyphicon glyphicon-menu-hamburger"> </span>

	    
	    <ul>
	        <li><a href="book.do">DIARY</a></li>
	        <li><a href="favorite.do">FAVORITES</a></li>
	        <li><a href="myPage.do">MYPAGE</a></li>
	    </ul>
	</nav>
	
	<div class="content" style="margin-top: 100px">
		<div id="main">
			
			  <div class="insertBook">
			  	<a href="insertBook.do" id="test"><span class="glyphicon glyphicon-plus" id="plus_location"></span></a>
			  </div>
		
			<div id="main_container"></div>
	
		</div>  
	</div>
</div>
    
<!-- 푸터  -->
<footer class="footer" >
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