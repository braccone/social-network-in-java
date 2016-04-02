<%@page import="com.pacchetto.servlets.Connessione"%>
<%@page import="com.pacchetto.servlets.Utente"%>
<%@include file="./include/Header.jsp" %>
	<%@page import="java.sql.ResultSet" %>
	<%@page import="com.mysql.jdbc.Connection" %>
	<%@page import="com.pacchetto.servlets.RisposteUtente" %>
	<%@page import="com.pacchetto.servlets.DomandaUtente" %>

	<div class="DomandePoste">
		<h1 style="color: blue;font-size: 22px;">La tua domanda</h1>
		<%
		ResultSet rs;
		Connection conn = Connessione.getConnection();
		String id_domanda = request.getParameter("id");
		rs = DomandaUtente.getDomanda(id_domanda,conn);
		while(rs.next()){
		%>
		
		<div id="Domande">
			<div id="data">
				<%=rs.getDate("data") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ora:&nbsp;<%=rs.getTime("ora") %>
			</div>
			<h2><%=rs.getString("titolo")%></h2>
			
			<%
				String descrizione=rs.getString("descrizione");
			//nel caso in cui non sia presente alcuna descrizione per la domanda scrive "nessuna descrizione."
				if(rs.getString("descrizione").length()<=1){
			%>
			<i>nessuna descrizione.</i><br><br>
			<%
				}
				else{
			%>
			<%=descrizione%><br><br>
			<% 
				}
			%>
			
		<!-- pubblicato il <%=rs.getDate("data") %> alle <%=rs.getTime("ora") %>  -->
		</div>
		<%
		}
		%>
	</div>
	<div class="Risposte">
		
		<%
			ResultSet rs_utente;
			rs = RisposteUtente.getRisposteDomande(id_domanda,conn);
			while(rs.next()){
		%>
		<div id="risposta">
			<%
				rs_utente=RisposteUtente.getUtente(rs.getInt("id_rispondente"),conn);
				rs_utente.next();	
			%>
			<%=rs_utente.getString("username") %>
			<% rs_utente.close(); %>
			<p><%=rs.getString("testo") %></p>
		</div>
		<%
			}
			rs.close();
			conn.close();
		%>
	
		<div id="FaiRisposta">
		<form method="post" action="Risposta">
			<textarea rows="7" cols="50" name="risposta"></textarea><br>
			<input type="submit" value="RISPONDI" name="btn_risposta">
			<input type="hidden" name="prova" value="<%=id_domanda %>">
		</form>
		</div>
	</div>
<%@include file="./include/Footer.jsp" %>