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
	%>
	<h1><%=rs_utente.getString("email") %></h1>
	<div id="interessi" contenteditable="false" style="background-color: white;">
		<% 
			int contatore=1;
			ResultSet rs = Interesse.getInteressi();
			while(rs.next())
				{
		%>
		<input type="checkbox" name="interesse[]" value=<%=rs.getInt("id_interesse")%>> <label><%=rs.getString("nome") %></label><br>
		 <%
		  	contatore++;}
			rs.close();
		  %>
	</div>

<%@include file="./include/Footer.jsp" %>