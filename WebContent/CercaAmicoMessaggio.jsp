<%@page import="com.pacchetto.servlets.Connessione"%>
<%@page import="com.pacchetto.servlets.Utente"%>
<%@include file="./include/Header.jsp" %>
	<%@page import="com.mysql.jdbc.Connection" %>
	<%@page import="java.sql.ResultSet" %>
	<%@page import="com.pacchetto.servlets.Interesse" %>
	<%@page import="com.pacchetto.servlets.DomandaUtente" %>

<div class="DomandaTutto"> <!-- forse non dovrebbe essere DomandaTutto né Domanda sotto -->
	<div class="Domanda">
	<h1>Cerca un amico</h1>
	<form name="nomeamico" method="post">
		<div id="titolo">
			<input type="text" placeholder="Inserisci il nome di un tuo amico" name="amico" onkeypress="return clickInvio(event)" ><br>
		</div>
		<input type="button" name="btn_cerca" value="Cerca" onClick="cercaamicomessaggio()" id="btn_cerca">
	</form>
	</div>
	<%
	///Se non riesce a prendere il paramentro search vuol dire che non c'è
	///e quindi la parte sotto non viene stampata
	String nomeamico = request.getParameter("search");
	if(nomeamico != null)
	{
	%>
	<div class="DomandePoste"> <!-- forse non dovrebbe essere DomandePoste -->
			<h1> Amici trovati </h1>
			<%
			int id_utente=0;
			Connection conn = Connessione.getConnection();
			ResultSet rs = Utente.getUtente(user,conn);
			while(rs.next())
			{
				id_utente = rs.getInt("id");
			}
			rs.close();
			ResultSet amici=Utente.cercaAmici(id_utente,nomeamico,conn);
			//Il resto viene stampato solo se il result set non è null
			if(amici != null)
			{
				while(amici.next())
				{
				%>
				<div id="Domande"> <!-- non dovrebbe essere Domande ma qualcosa come "utenti", per il momento è così per questioni pratiche -->
					<h2><a href="InviaMessaggio.jsp?id=<%=amici.getInt("id")%>">
						<img alt="non funziona" height="100" width="100" src=<%=amici.getString("immagine") %>>
						<%=amici.getString("username")%>
					</a></h2>
				</div>
				<%
				}
				%>
			<%
			}
			%>
	</div>
	<%
		conn.close();
	}
	
	%>
</div>
<%@include file="./include/Footer.jsp" %>