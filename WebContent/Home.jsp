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
		<div class="DomandePoste">
			<h1>Domande</h1>
			<%
			ResultSet rs;
			/*rs = Utente.getUtente(user);
			int id_domandante = 0;
			while(rs.next()){
				id_domandante = rs.getInt("id");
			}
			rs.close();*/
			
			//Non c'era prima, ritorna l'id dell'utente
			ResultSet rs_utente = Utente.getUtente(user);
			rs_utente.next();
			int id_utente = rs_utente.getInt("id");
			////////////////////////////////////////
			
			//rs = DomandaUtente.getTutto(); //c'era questa che mostrava tutte le domande
			//ora invece deve mostrare solo le domande che interessano all'utente
			rs=DomandaUtente.getDomandeInteresseP(id_utente);
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
			}
			%>
		</div>
	</div>
<%@include file="./include/Footer.jsp" %>