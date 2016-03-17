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
<div class="DomandaTutto"> <!-- forse non dovrebbe essere DomandaTutto né Domanda sotto -->
	<div class="Domanda">
	<h1>Cerca un amico</h1>
	<form name="nomeamico" method="post">
		<div id="titolo">
				<input type="text" placeholder="Inserisci il nome di un tuo amico" name="amico"><br>
		</div>
		<input type="button" name="btn_cerca" value="Cerca" onClick="cercaamicomessaggio()">
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
			ResultSet rs = Utente.getUtente(user);
			while(rs.next())
			{
				id_utente = rs.getInt("id");
			}
			rs.close();
			ResultSet amici=Utente.cercaAmici(id_utente,nomeamico);
			//Il resto viene stampato solo se il result set non è null
			if(amici != null)
			{
				while(amici.next())
				{
				%>
				<div id="Domande"> <!-- non dovrebbe essere Domande ma qualcosa come "utenti", per il momento è così per questioni pratiche -->
					<h2><a href="InviaMessaggio.jsp?id=<%=amici.getInt("id")%>"><%=amici.getString("username")%></a></h2>
				</div>
				<%
				}
				%>
			<%
			}
			%>
	</div>
	<%
	}
	%>
</div>
<%@include file="./include/Footer.jsp" %>