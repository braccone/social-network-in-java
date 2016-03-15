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
	<div class="DomandaTutto">
		<div class="Domanda">
		<h1>Fai una domanda</h1>
			<div id="titolo">
				<form name="faidomanda" method="post">
					<input type="text" placeholder="Inserisci il titolo" name="titolo"><br>
					<textarea rows="9" cols="50" placeholder="Inserisci la domanda" name="descrizione"></textarea><br>
					<div id="interessi" contenteditable="false">
						<% 
							int contatore=1;
							ResultSet rs = Interesse.getInteressi();
							while(rs.next())
							{
						%>
								<input type="checkbox" name="interesse[]" value=<%=rs.getInt("id_interesse")%>> <label><%=rs.getString("nome") %></label><br><!-- alla fine c'era <br> e non c'erano gli spazi &nbsp -->
		  				<%
		  					contatore++;}
							rs.close();
		  				%>
	  				</div>
	  				<input type="button" name="btn_domanda" value="Conferma" onclick="ConfermaDomanda()">
				</form>
			</div>
		</div>
	
		<div class="DomandePoste">
			<h1>Le tue domande</h1>
			<%
			rs = Utente.getUtente(user);
			int id_domandante = 0;
			while(rs.next()){
				id_domandante = rs.getInt("id");
			}
			rs.close();
			rs = DomandaUtente.getDomande(id_domandante);
			while(rs.next()){
			%>
			
			<div id="Domande">
				<div id="data">
					<%=rs.getDate("data") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ora:&nbsp;<%=rs.getTime("ora") %>
				</div>
				<h2><a href="Risposta.jsp?id=<%=rs.getInt("id_domanda")%>"><%=rs.getString("titolo")%></a></h2>
				
				<%
					String descrizione=rs.getString("descrizione");
					if(descrizione.length()>54){
						descrizione = descrizione.substring(0, 54)+"...";	
					}
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
	</div>
<%@include file="./include/Footer.jsp" %>