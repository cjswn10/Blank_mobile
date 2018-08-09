var canvas = document.getElementById("canvas");
var context = canvas.getContext("2d");
var selectColor = document.getElementById("selectColor");
var myColor = document.getElementById("myColor");
var drawBackup = new Array();

context.strokeStyle = myColor.value;
context.lineWidth = document.getElementById("Lwidth").value;
canvas.addEventListener("mousedown", function(e) {
	down(e)
}, false);
canvas.addEventListener("mouseup", function(e) {
	up(e)
}, false);
canvas.addEventListener("mousemove", function(e) {
	move(e)
}, false);
canvas.addEventListener("mouseout", function(e) {
	out(e)
}, false);

function changeColor(color) {
	switch (color) {
	case '#FF0000':
		return "#FF0000";
	case '#FF5E00':
		return "#FF5E00";
	case '#FFBB00':
		return "#FFBB00";
	case '#FFE400':
		return "#FFE400";
	case '#ABF200':
		return "#ABF200";
	case '#1DDB16':
		return "#1DDB16";
	case '#00D8FF ':
		return "#00D8FF";
	case '#0054FF':
		return "#0054FF";
	case '#0100FF':
		return "#0100FF";
	case '#5F00FF':
		return "#5F00FF";
	case '#FF00DD':
		return "#FF00DD";
	case '#FF007F':
		return "#FF007F";
	case '#000000':
		return "#000000";
	case '#FFFFFF':
		return "#FFFFFF";
	case '#F6CECE':
		return "#fffcf0";
	case '#FFA7A7':
		return "#FFA7A7";
	case '#FFC19E':
		return "#FFC19E";
	case '#FFE08C':
		return "#FFE08C";
	case '#FAED7D':
		return "#FAED7D";
	case '#CEF279':
		return "#CEF279";
	case '#B7F0B1':
		return "#B7F0B1";
	case '#B2EBF4':
		return "#B2EBF4";
	case '#B2CCFF':
		return "#B2CCFF";
	case '#B5B2FF':
		return "#B5B2FF";
	case '#D1B2FF':
		return "#D1B2FF";
	case '#FFB2F5':
		return "#FFB2F5";
	case '#FFB2D9':
		return "#FFB2D9";
	case '#D5D5D5':
		return "#D5D5D5";
	case '#BDBDBD':
		return "#BDBDBD";
	default:
		return color;
	}
}
function cg_color(color) {
	context.strokeStyle = color;
	selectColor.style.background = color;
	myColor.value = changeColor(color);
}

function cg_line(width) {
	context.lineWidth = width;
}

var startX = 0,
	startY = 0;
var drawing = false;


function down(e) {
	drawBackup.push(context.getImageData(0, 0, canvas.width, canvas.height));
	startX = e.offsetX;
	startY = e.offsetY;
	drawing = true;
}

function move(e) {
	if (!drawing)
		return;
	var curX = e.offsetX;
	var curY = e.offsetY;
	draw(curX, curY);
	startX = curX;
	startY = curY;
}

function draw(curX, curY) {
	drawBackup.push(context.getImageData(0, 0, canvas.width, canvas.height));
	context.beginPath();
	context.moveTo(startX, startY);
	context.lineTo(curX, curY);
	context.stroke();
	
}

function up(e) {
	drawing = false;
}

function out(e) {
	drawing = false;
}


// 지우기
document.getElementById("delete").addEventListener("click", function(e) {
	context.clearRect(0, 0, canvas.width, canvas.height);
}, false);
// 되돌리기
document.getElementById("prev").addEventListener("click", function(e) {
	context.putImageData(drawBackup.pop(), 0, 0);
},false);








