<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html manifest="resources/conf/bit.manifest">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="with=device-width,
initial-scale=1.0,
maximum-scale=1.0,
minimum-scale=1.0,
user-scalable=no">
<link rel="shortcut-touch-icon" href="resources/img/bit.png">
<link rel="apple-touch-icon" href="resources/img/bit.png">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#download").click(function() {
			downloadCanvas(this, 'canvas', 'myGrim.png');
		});

		$("#btnOk").click(function() {

			var myImage = document.getElementById("myImage");
			var imageUrl = canvas.toDataURL();
			myImage.src = canvas.toDataURL();

			self.close();
		});
	});

	//C:\Blank\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Blank\resources\upload2
	// 작업 이미지 로컬 다운로드(.PNG)
	function downloadCanvas(link, canvasId, filename) {
		link.href = document.getElementById(canvasId).toDataURL();
		link.download = filename;
	}
</script>
<body>
<div data-role="content">
	<div>
		<canvas id="canvas" width="400px" height="400px" style=" display:inline-block;"></canvas>
	</div>
</div>
	
	<script type="text/javascript" src="../resources/js/drawingColor.js?ver=18"></script>
	
	<input type="hidden" id="selectColor">
	<input type="color" id="myColor" onchange="cg_color(this.value)">
	
	Size:<input type="range" min="1" max="5" id="Lwidth" value="1" onchange="cg_line(this.value)">

		<button data-inline='true' style='margin:0px auto;' id="delete"><img src="../resources/img/icon/newpage.png" width="15px"></button>
		<button data-inline='true' style='margin:0px auto;' id="prev"><img src="../resources/img/icon/prev.png" width="15px"></button>
		<a id="download"><button data-inline='true' style='margin:0px auto;'><img src="../resources/img/icon/download.png" width="15px"></button></a>
		<button data-inline='true' style='margin:0px auto;' id="btnOk"><img src="../resources/img/icon/exit.png" width="15px"></button>
	
	
	<img id="myImage">

	<script src="../resources/js/draw.js"></script>
</body>
</html>

