<%@page import="com.pacchetto.servlets.Utente"%>
<%@include file="./include/Header.jsp" %>
	<%@page import="java.sql.ResultSet" %>
	<%@page import="com.pacchetto.servlets.Interesse" %>
	<%@page import="com.pacchetto.servlets.DomandaUtente" %>
	<%@page import="com.pacchetto.servlets.InteressiUtente" %>
	<%@page import="com.pacchetto.servlets.Messaggio" %>
	<%@page import="com.pacchetto.servlets.Utente" %>
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
	<!--  
	<div class="SceltaHomeMessaggi">
		<a href="InviaMessaggio.jsp">Invia un messaggio</a>
		<a href="MessaggioInviato.jsp">Vedi i messaggi che hai inviato</a>
	</div> -->
	
	<div class="DomandePoste">
		<h2> Messaggi Inviati </h2><br>
		<%
		ResultSet rs;
		ResultSet rsutente;
		int id_messaggio;
		String nomeutente;
		String testo;
		rs=Utente.getUtente(user);
		//Inserimento dell'id utente nella variabile apposita
		//Dovrei fare dei controlli e vedere se non è null
		rs.next();
		int id=rs.getInt("id");
		rs=Messaggio.get_MessaggiInviati(id);
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
				<!-- ce sta da cambià 'sto messaggio.jsp -->
				<h2><a href="Messaggio.jsp?id=<%=id_messaggio%>"><%=testo%></a></h2>
				<%
					rsutente=Messaggio.get_Destinatario(id_messaggio);
					rsutente.next(); //forse ce devo mette un controllo
					nomeutente=rsutente.getString("username");
				%>
				<i>Inviato a <%=nomeutente%></i><br><br>
			</div>
		<%
		}
		%>
	</div>
<%@include file="./include/Footer.jsp" %>