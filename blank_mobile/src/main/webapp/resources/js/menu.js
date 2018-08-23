/**
 * side-menu 
 */
function openNav() {
    document.getElementById("mySidenav").style.width = "250px";
    document.getElementById("wrapper").style.left = "-250px";
    document.getElementById("wrapper").style.position = "relative";
}

function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
    document.getElementById("wrapper").style.left= "0";
    document.getElementById("wrapper").style.position = "static";
}

function openSearch() {
	document.getElementById("mainSearchId").style.display = "block";
	document.getElementById("mainSearchId_inner").style.display = "block";
}

function closeSearch() {
	document.getElementById("mainSearchId").style.display = "none";
	document.getElementById("mainSearchId_inner").style.display = "none";
}

function openNav() {
    document.getElementById("mySidenav").style.width = "250px";
    document.getElementById("wrapper").style.left = "-250px";
    document.getElementById("wrapper").style.position = "relative";
}

function openMenu() {
	
    var x = document.getElementById("main_menu");
    
    if (x.style.height == 0 || x.style.height === "0px") {
        x.style.height = "auto";
    } else {
        x.style.height = "0";
    }
    /*
    if (x.style.display === "none") {
        x.style.display = "block";
    } else {
        x.style.display = "none";
    }
    */
    
}