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
	<%
		String id_domanda = request.getParameter("id");
	
		ResultSet rs = RisposteUtente.getRisposteDomande(Integer.parseInt(id_domanda));
		while(rs.next()){
	%>
	<p><%=rs.getString("testo") %></p>
	<%} %>
	<form method="post" action="#">
		<textarea rows="7" cols="50"></textarea><br>
		<input type="button" value="RISPONDI" name="btn_risposta">
	</form>
<%@include file="./include/Footer.jsp" %>