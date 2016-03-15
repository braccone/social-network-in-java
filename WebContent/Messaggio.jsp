<%@page import="com.pacchetto.servlets.Utente"%>
<%@include file="./include/Header.jsp" %>
	<%@page import="java.sql.ResultSet" %>
	<%@page import="com.pacchetto.servlets.Interesse" %>
	<%@page import="com.pacchetto.servlets.DomandaUtente" %>
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
	
	<!-- dovrebbe prendere l'id dell'utente [da fare] -->
	
	<div class="DomandaTutto"> <!--  da cambiare nome -->
		<div class="Domanda"> <!--  cambiare nome -->
		<h1>Messaggio</h1>
			<div id="titolo">
				<form name="faidomanda" method="post">
					<textarea rows="9" cols="50" placeholder="Inserisci la domanda" name="descrizione"></textarea><br>
					
	  				<input type="button" name="btn_invia" value="Invia" onclick=""> <!-- inserire funzione che invia il messaggio -->
				</form>
			</div>
		</div>
	
		<div class="MessaggiInviatiRicevuti"> <!-- era DomandePoste -->
			<h1>I tuoi messaggi con l'utente</h1>
			<%
			ResultSet rs;
			rs = Utente.getUtente(user);
			int id_utente = 0;
			//Inserimento dell'id 
			while(rs.next()){
				id_utente = rs.getInt("id");
			}
			rs.close();
			while(rs.next())
			{
			%>
			
			<!-- da fare -->
			
			<%
			}
			%>
		</div>
	</div>
<%@include file="./include/Footer.jsp" %>