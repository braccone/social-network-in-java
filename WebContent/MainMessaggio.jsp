<%@page import="com.pacchetto.servlets.Utente"%>
<%@include file="./include/Header.jsp" %>
	<%@page import="java.sql.ResultSet" %>
	<%@page import="com.pacchetto.servlets.Interesse" %>
	<%@page import="com.pacchetto.servlets.DomandaUtente" %>
	<%@page import="com.pacchetto.servlets.InteressiUtente" %>
	<%
		//allow access only if session exists
		/*String utente = request.getParameter("u");
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
		}*/
	%>
	<div class="SceltaHomeMessaggi">
		<a href="InviaMessaggio.jsp">Invia un messaggio</a>
	</div>
	
	<div class="MessaggiRicevuti">
		<h2> Messaggi Ricevuti </h2>
		<%
		ResultSet rs;
		int id_utente;
		rs=Utente.getUtente(user);
		//Inserimento dell'id utente nella variabile apposita
		id_utente=rs.getInt("id");
		%>
	</div>
<%@include file="./include/Footer.jsp" %>