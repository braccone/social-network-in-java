function Control(){
	var username = document.modulo.username.value;
	var email1 = document.modulo.email.value;
	var email2 = document.modulo.email2.value;
	var pass1 = document.modulo.password.value;
	var pass2 = document.modulo.password2.value;
	var email_reg_exp = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-]{2,})+\.)+([a-zA-Z0-9]{2,})+$/;

	if ((username === "") || (username == "undefined")) {
   		alert("Il campo Username obbligatorio.");
    	document.modulo.username.focus();
   		return false;
	}
	if(username.match(' ')){
        alert('Gli spazi non sono permessi!');
        return false;
     }
	if (!email_reg_exp.test(email1) || (email1 === "") || (email1 == "undefined")) {
    	alert("Inserire un indirizzo email corretto.");
    	document.modulo.email.select();
   		return false;
	}
	if(email1 != email2){
		alert("L'email confermata diversa da quella scelta, controllare.");
		document.modulo.email2.value = "";
		document.modulo.email2.focus();
		return false;
	}
	if(pass1.length<=5 || pass1.length>32 || pass1==="" || pass1=="undefined" || pass1==null){
		alert("La password deve essere almeno 6 caratteri e massimo 32");
		document.modulo.password2.value = "";
		document.modulo.password.focus();
		return false;
	}
	if (pass1 != pass2) {
    	alert("La password confermata diversa da quella scelta, controllare.");
    	document.modulo.password2.value = "";
    	document.modulo.password2.focus();
    	return false;
    }
	else {
   		document.modulo.action = "Registrazione";
   		document.modulo.submit();
	}

}
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
function ConfermaDomanda(){
	var titolo = document.faidomanda.titolo.value;
	var domanda = document.faidomanda.descrizione.value;
	var interessi = document.getElementsByName("interesse[]");
	var lunghezza = document.getElementsByName("interesse[]").length;

	if(titolo === "" || titolo =="undefined" || titolo=="NULL"){
		alert("Il titolo della domanda non puo' essere vuoto.");
		document.faidomanda.titolo.focus();
		return false;
	}
	if(titolo.length < 7){
		alert("La domanda contiene troppe poche lettere per avere senso.");
		document.faidomanda.titolo.focus();
		return false;
	}
	if(titolo.substr(titolo.length-1) != "?"){
		alert("Il titolo della domanda deve obbligatoriamente finire con un punto di domanda('?').");
		document.faidomanda.titolo.focus();
		return false;
	}
	for(i=0;i<lunghezza;i++){
		if(interessi[i].checked){
			break;
		}
		
	}
	if(titolo.length > 255){
		alert("Il titolo della domanda non puo' avere piu' di 255 caratteri.");
		document.faidomanda.titolo.focus();
		return false;
	}
	if(domanda.length > 512){
		alert("La descrizione della domanda non puo' superare i 512 caratteri.");
		document.faidomanda.domanda.focus();
		return false;
	}
	var j=0;
	while(j<document.getElementsByName("interesse[]").length){
		if(interessi[j].checked){
			interessi[j].name="select[]";
			continue;
		}
		j++;
		
	}
	if(i==lunghezza){
		alert("Devi almeno scegliere un interesse tra quelli elencati.");
		return false;
	}
	else {
   		document.faidomanda.action = "Domanda";
   		document.faidomanda.submit();
	}
}