var colorName = [ '#FF0000', '#FF5E00', '#FFBB00', '#FFE400', '#ABF200',
		'#1DDB16', '#00D8FF', '#0054FF', '#0100FF', '#5F00FF',
		'#FF00DD', '#FF007F', '#000000', '#FFFFFF', '#FFA7A7', '#FFC19E',
		'#FFE08C', '#FAED7D', '#CEF279', '#B7F0B1', '#B2EBF4', '#B2CCFF',
		'#B5B2FF', '#D1B2FF', '#FFB2F5', '#FFB2D9', '#D5D5D5', '#BDBDBD' ];
for (var i = 0; i < 27; i++) {
	if(i==14){
		document.write("<br>");
	}
	document.write("<input type='button' id='" + colorName[i]
			+ "' onclick='cg_color(this.id)'>");
}
for (var i = 0; i < 27; i++) {
	var inputColor = document.getElementById(colorName[i]);
	inputColor.style.background = colorName[i];
}