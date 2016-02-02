<%@page import="com.pacchetto.servlets.Utente"%>
<%@include file="./include/Header.jsp" %>
	<%@page import="java.sql.ResultSet" %>
	<%@page import="com.pacchetto.servlets.RisposteUtente" %>
	<%@page import="com.pacchetto.servlets.DomandaUtente" %>
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
	<div class="DomandePoste">
		<h1 style="color: blue;font-size: 22px;">La tua domanda</h1>
		<%
		ResultSet rs;
		String id_domanda = request.getParameter("id");
		rs = DomandaUtente.getDomanda(id_domanda);
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
		<div id="risposte">
		<%
		
			rs = RisposteUtente.getRisposteDomande(id_domanda);
			while(rs.next()){
		%>
		<p><%=rs.getString("testo") %></p>
		<%} %>
		</div>
		<div id="FaiRisposta">
		<form method="post" action="Risposta">
			<textarea rows="7" cols="50" name="risposta"></textarea><br>
			<input type="submit" value="RISPONDI" name="btn_risposta">
			<input type="hidden" name="prova" value="<%=id_domanda %>">
		</form>
		</div>
	</div>
<%@include file="./include/Footer.jsp" %>