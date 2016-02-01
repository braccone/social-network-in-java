<!DOCTYPE html>
<html>
	<head>
	
		<title>LikeQuora</title>
		
		<link rel="stylesheet" type="text/css" href="./css/PaginaLogin.css">
		<script type="text/javascript" src="./js/Controllo.js"></script>
		<noscript>
			<meta http-equiv=refresh content="0; url=https://www.google.it">
		</noscript>
	</head>
	
	<body>
<div class="Sign">
	<table>
		<tr>
			<td width="60%" valign="top">
				<h2>Join LikeQuora!</h2>
				<form action="Login" method="POST">
					<input type="text" name="user_login" size="25" placeholder="Username"/><br/><br/>
					<input type="password" name="password_login" size="25" placeholder="Password"/><br /><br/>
					<input type="submit" name="login" value="Login" />
				</form>
			</td>
			<td width="40%" valign="top">
				<h2>Registrati Sotto!</h2>
				<form  method="POST" name="modulo">
					<input type="text" name="username" size="25" placeholder="Username"/><br/><br/>
					<input type="text" name="email" size="25" placeholder="E-mail"/><br/><br/>
					<input type="text" name="email2" size="25" placeholder="Ripeti E-mail"/><br/><br/>
					<input type="password" name="password" size="25" placeholder="Password"/><br/><br/>
					<input type="password" name="password2" size="25" placeholder="Ripeti password"/><br/><br/>
					<input type="button" name="invia" value="Registati" onClick="Control()" />
				</form>
			</td>
		</tr>
	</table>
</div>
<%@include file="./include/Footer.jsp" %>