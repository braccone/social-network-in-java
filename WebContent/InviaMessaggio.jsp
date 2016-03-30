<%@page import="com.pacchetto.servlets.Utente"%>
<%@include file="./include/Header.jsp" %>
	<%@page import="java.sql.ResultSet" %>
	<%@page import="com.pacchetto.servlets.Interesse" %>
	<%@page import="com.pacchetto.servlets.DomandaUtente" %>
	<%@page import="com.pacchetto.servlets.Messaggio" %>
	
	
	<%
	String id_destinatario = request.getParameter("id");
	if(id_destinatario==null){
		response.sendRedirect("Home.jsp");
	}
	ResultSet rs = Utente.getUtenteXId(Integer.parseInt(id_destinatario));
	if(!rs.next()){
		response.sendRedirect("Home.jsp");
	}
	String nomemittente = rs.getString("username");
	%>
	
	<form name="inviamessaggio" method="post">
	<div class="DomandaTutto">
		<div class="Domanda">
		<h1>Invia un messaggio a <%=nomemittente%> </h1>
					<input type="hidden" name="destinatario" value=<%=id_destinatario%>> 
					<textarea rows="9" cols="50" placeholder="Inserisci il messaggio" name="descrizione"></textarea><br>
	  				<input type="button" name="btn_domanda" value="Conferma" onclick="ConfermaMessaggio()">
		</div>
	</div>
	</form>
<%@include file="./include/Footer.jsp" %>