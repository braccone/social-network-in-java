<%@page import="com.pacchetto.servlets.Connessione"%>
<%@page import="com.pacchetto.servlets.Utente"%>
<%@include file="./include/Header.jsp" %>
	<%@page import="java.sql.ResultSet" %>
	<%@page import="com.mysql.jdbc.Connection" %>
	<%@page import="com.pacchetto.servlets.Interesse" %>
	<%@page import="com.pacchetto.servlets.DomandaUtente" %>
	<%@page import="com.pacchetto.servlets.InteressiUtente" %>
	<%@page import="com.pacchetto.servlets.Messaggio" %>
	<%@page import="com.pacchetto.servlets.Utente" %>
	<!--  
	<div class="SceltaHomeMessaggi">
		<a href="InviaMessaggio.jsp">Invia un messaggio</a>
		<a href="MessaggioInviato.jsp">Vedi i messaggi che hai inviato</a>
	</div> -->
	
	<div class="DomandePoste">
		<h2> Messaggi Ricevuti </h2><br>
		<a href="CercaAmicoMessaggio.jsp">Invia un messaggio</a><br>
		<a href="MessaggioInviato.jsp">Vedi i messaggi che hai inviato</a><br>
		<%
		ResultSet rs;
		ResultSet rsutente;
		int id_messaggio;
		String nomeutente;
		String testo;
		Connection conn = Connessione.getConnection();
		rs=Utente.getUtente(user,conn);
		//Inserimento dell'id utente nella variabile apposita
		//Dovrei fare dei controlli e vedere se non � null
		rs.next();
		int id=rs.getInt("id");
		rs=Messaggio.get_MessaggiRicevuti(id,conn);
		while(rs.next())
		{
		%>
			<div id="Domande">
				<div id="data">
					<%=rs.getDate("data") %>
				</div>
				<%
				id_messaggio=rs.getInt("id_messaggio");
				testo=rs.getString("testo");
				if(testo.length()>54){
					testo = testo.substring(0, 54)+"...";	
				}
				%>
				<h2><a href="Messaggio.jsp?id=<%=id_messaggio%>"><%=testo%></a></h2>
				<%
					rsutente=Messaggio.get_Mittente(id_messaggio,conn);
					rsutente.next(); //forse ce devo mette un controllo
					nomeutente=rsutente.getString("username");
				%>
				<i>Inviato da <%=nomeutente%></i><br><br>
			</div>
		<%
		}
		conn.close();
		%>
	</div>
<%@include file="./include/Footer.jsp" %>