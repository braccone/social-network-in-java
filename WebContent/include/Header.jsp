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
	<%
		//allow access only if session exists
		String utente = request.getParameter("u");
		String user = null;
		if(session.getAttribute("user") == null){
			response.sendRedirect("Index.jsp");
		}
		else{ 
			user = (String) session.getAttribute("user");
			if(utente != null){
				if(utente != user){
					response.sendRedirect("Index.jsp");
				}
			}
		}
	%>
	<div class="tutto">
		<div class="HeaderMenu">
			<div id="menu">
				<ul>
			  		<li><a href="Home.jsp">Home</a></li>
			  		<li><a href="Domanda.jsp">Fai una domanda</a></li>
			  		<li><a href="#">Messaggi</a></li>
			  		<li><a href="Profilo.jsp"><%=user %></a></li>
				</ul>
			</div>
			<div id="SearchContainer">
				<form method="GET" action="DomandeTrovate.jsp" id="SearchForm"> <!-- c'era # -->
					<div id="SearchBox">
						<input type="text" name="titolo" id="sb" onfocus="SearchBoxSwap('BarraRicerca_focus.png')" onblur="SearchBoxSwap('BarraRicerca.png')" /> <!-- il nome non era titolo ma query -->
					</div>
					<div id="SearchBtn">
						<input type="image" src="./img/PulsanteRicerca.png" name="submit" id="search_btn" alt="Btn" onmouseover="ButtonSwap('PulsanteRicerca_hover.png')" onmouseout="ButtonSwap('PulsanteRicerca.png')"/>
					</div>
				</form>
			</div>
		</div>
		<br>
		<br>
		<br>
		<br>
		<br>
		
		