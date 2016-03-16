<%@page import="com.pacchetto.servlets.Utente"%>
<%@include file="./include/Header.jsp" %>
	<%@page import="java.sql.ResultSet" %>
	<%@page import="com.pacchetto.servlets.RisposteUtente" %>
	<%@page import="com.pacchetto.servlets.DomandaUtente" %>
	<%@page import="com.pacchetto.servlets.Messaggio" %>
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
	<div class="DomandePoste">
		<h1 style="color: blue;font-size: 22px;">Messaggio</h1>
		<%
		ResultSet rs; //Result set per il messaggio
		ResultSet mittente; //Result set che contiene le informazioni relative al mittente
		String id_messaggio = request.getParameter("id"); //prende l'id del messaggio
		rs = Messaggio.Get_Messaggio(Integer.parseInt(id_messaggio));
		mittente = Messaggio.Get_Mittente(Integer.parseInt(id_messaggio));
		while(rs.next())
		{
			mittente.next(); //forse devo fare qualche controllo
		%>
			<div id="Domande"> <!-- in realtà è messaggio -->
				<div id="data">
					Da: <%=mittente.getString("username")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=rs.getDate("data") %>
				</div>
				<h2><%=rs.getString("testo")%></h2>
			</div>
		<%
		}
		%>
	</div>
	
	<div class="Risposte">
		<div id="Domanda">
		<form method="post" action="Messaggia">
			<textarea rows="7" cols="50" name="messaggia"></textarea><br>
			<input type="submit" value="MESSAGGIA" name="btn_risposta">
			<input type="hidden" name="prova" value="0"> <!-- su value ci andrà qualcosa -->
		</form>
		</div>
	</div>
<%@include file="./include/Footer.jsp" %>