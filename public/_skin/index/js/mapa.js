function p24_krajeMapa(idDOM,kolik) {
	if (kolik < 8) {
		document.getElementById(idDOM).style.backgroundPosition = "0px -"+(kolik*160)+"px";
	} 
	else {
		document.getElementById(idDOM).style.backgroundPosition = "-200px -"+((kolik-7)*160)+"px";
	}
}

