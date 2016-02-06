<!DOCTYPE html>
<html>
	<head>
		<title>LikeQuora</title>
		<link rel="stylesheet" type="text/css" href="./css/stile.css">
		<script type="text/javascript" src="./js/Controllo.js">
		</script>
		<noscript>
		    <style type="text/css">
		        .tutto {display:none;}
		    </style>
		    <meta http-equiv=refresh content="2; url=http://www.miosito.com">
		    <div class="noscriptmsg">
		    You don't have javascript enabled.  Good luck with that.
		    </div>
		</noscript>
	</head>
	<body>
	<div class="tutto">
		<div class="HeaderMenu">
			<div id="menu">
				<ul>
			  		<li><a href="Home.jsp">Home</a></li>
			  		<li><a href="Domanda.jsp">Fai una domanda</a></li>
			  		<li><a href="#">Messaggi</a></li>
			  		<li><a href="#">Amici</a></li>
			  		<li><a href="Profilo.jsp">Profilo</a></li>
				</ul>
			</div>
			<div id="SearchContainer">
				<form method="GET" action="#" id="SearchForm">
					<div id="SearchBox">
						<input type="text" name="query" id="sb" onfocus="SearchBoxSwap('BarraRicerca_focus.png')" onblur="SearchBoxSwap('BarraRicerca.png')" />
					</div>
					<div id="SearchBtn">
						<input type="image" src="./img/PulsanteRicerca.png" name="submit" id="search_btn" alt="Btn" onmouseover="ButtonSwap('PulsanteRicerca_hover.png')" onmouseout="ButtonSwap('PulsanteRicerca.png')" />
					</div>
				</form>
			</div>
		</div>
		<br>
		<br>
		<br>
		<br>
		<br>
		
		