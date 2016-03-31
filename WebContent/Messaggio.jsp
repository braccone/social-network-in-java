<%@page import="com.pacchetto.servlets.Connessione"%>
<%@page import="com.pacchetto.servlets.Utente"%>
<%@include file="./include/Header.jsp" %>
	<%@page import="java.sql.ResultSet" %>
	<%@page import="com.mysql.jdbc.Connection" %>
	<%@page import="com.pacchetto.servlets.RisposteUtente" %>
	<%@page import="com.pacchetto.servlets.DomandaUtente" %>
	<%@page import="com.pacchetto.servlets.Messaggio" %>
	<div class="DomandePoste">
		<h1 style="color: blue;font-size: 22px;">Messaggio</h1>
		<%
		ResultSet rs; //Result set per il messaggio
		ResultSet mittente; //Result set che contiene le informazioni relative al mittente
		String id_messaggio = request.getParameter("id"); //prende l'id del messaggio
		Connection conn= Connessione.getConnection();
		rs = Messaggio.get_Messaggio(Integer.parseInt(id_messaggio),conn);
		mittente = Messaggio.get_Mittente(Integer.parseInt(id_messaggio),conn);
		Messaggio.leggi_Messaggio(Integer.parseInt(id_messaggio));
		while(rs.next())
		{
			if(mittente.next()){ //forse devo fare qualche controllo
		%>
			<div id="Domande">
				<div id="data">
					Da: <%=mittente.getString("username")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=rs.getDate("data") %>
				</div>
				<h2><%=rs.getString("testo")%></h2>
			</div>
		<%
			}
		}
		conn.close();
		%>
	</div>
	
	<div class="Risposte">
		<div id="Domanda">
		<form method="post" action="Messaggia">
			<textarea rows="7" cols="50" name="messaggia"></textarea><br>
			<input type="submit" value="MESSAGGIA" name="btn_risposta">
		</form>
		</div>
	</div>
<%@include file="./include/Footer.jsp" %>