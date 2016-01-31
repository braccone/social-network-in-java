function SearchBoxSwap(image){
	var sf = document.getElementById('sb');
	if (sf.value==="") {
		sf.style.background = "url(./img/"+image+") no-repeat";
	}
}
function ButtonSwap(image){
	var sf = document.getElementById('search_btn');
	if (sf.value==="") {
		sf.src = "./img/"+image;
	}
}