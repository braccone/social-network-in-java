//funzione che invia una domanda ad un utente
function ConfermaMessaggio(id){
	alert("sono entrato, l'id e' "+id+"");
	var messaggio = document.inviamessaggio.descrizione.value;
	var id_destinatario=id;
	if(messaggio.length > 512){
		alert("Il messaggio non puo' avere più di 512 caratteri");
		document.inviomessaggio.descrizione.focus();
		return false;
	}
	if(messaggio.length < 1){
		alert("Il messaggio non puo' essere vuoto");
		document.inviomessaggio.descrizione.focus();
		return false;
	}
   	document.faidomanda.action = "InviaMessaggio";
   	document.faidomanda.submit();
};
