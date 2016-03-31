<%@page import="com.pacchetto.servlets.Connessione"%>
<%@page import="com.pacchetto.servlets.Utente"%>
<%@include file="./include/Header.jsp" %>
	<%@page import="java.sql.ResultSet" %>
	<%@page import="com.mysql.jdbc.Connection" %>
	<%@page import="com.pacchetto.servlets.Interesse" %>
	<%@page import="com.pacchetto.servlets.DomandaUtente" %>
	<div class="DomandaTutto">
		<div class="DomandePoste">
			<h1>Domande</h1>
			<%
			/*rs = Utente.getUtente(user);
			int id_domandante = 0;
			while(rs.next()){
				id_domandante = rs.getInt("id");
			}
			rs.close();*/
			Connection conn=Connessione.getConnection();
			//Non c'era prima, ritorna l'id dell'utente
			ResultSet rs_utente = Utente.getUtente(user,conn);
			if(rs_utente.next()){
			int id_utente = rs_utente.getInt("id");
			////////////////////////////////////////
			
			//rs = DomandaUtente.getTutto(); //c'era questa che mostrava tutte le domande
			//ora invece deve mostrare solo le domande che interessano all'utente
			ResultSet rs=DomandaUtente.getDomandeInteresseP(id_utente,conn);
			while(rs.next()){
			%>
			
			<div id="Domande">
				<div id="data">
					<%=rs.getString("ut.username")%> &nbsp;&nbsp;&nbsp;&nbsp; <%=rs.getDate("data") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ora:&nbsp;<%=rs.getTime("ora") %>
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
			}rs.close();}
			rs_utente.close();
			conn.close();
			%>
		</div>
	</div>
<%@include file="./include/Footer.jsp" %>