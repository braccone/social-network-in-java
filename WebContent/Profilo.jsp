<%@page import="com.pacchetto.servlets.Utente"%>
<%@include file="./include/Header.jsp" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="com.pacchetto.servlets.Interesse" %>

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
	<h1>Ciao utente <%=user %></h1>
	<%
		ResultSet rs_utente = Utente.getUtente(user);
		rs_utente.next();
		int id_utente=rs_utente.getInt("id"); //prendo l'id dell'utente
	%>
	<h1><%=rs_utente.getString("email") %></h1>
	<div id="interessi" contenteditable="false" style="background-color: white;">
		<% 
			int contatore=1;
			ResultSet rs = Interesse.getInteressi();
			while(rs.next())
			{
				//se l'interesse è stato seguito allora lo stampa:
				if(Interesse.test_Interesseseguito(id_utente,rs.getInt("id_interesse")))
				{
		%>
					 <label><%=rs.getString("nome") %></label><br>
		<%		}
		 	}
			rs.close();
		%>
		<input type="button" onclick="location.href='Interessi.jsp';" value="Modifica Interessi" />
	</div>
	
	<div id="listaamici">
	<h1>Amici</h1>
	<a href="AggiungiAmico.jsp">Invia richiesta di amicizia</a>
		<%
		rs = Utente.getAmici(id_utente);
		while(rs.next())
		{
		%>
				<div id="Domande">
				<h2><a href="ProfiloEsterno.jsp?id=<%=rs.getInt("id")%>"><%=rs.getString("ut.username")%></a></h2>
				</div>
		<%
		}
		%>
	</div>

<%@include file="./include/Footer.jsp" %>