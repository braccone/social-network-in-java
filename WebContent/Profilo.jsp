<%@page import="com.pacchetto.servlets.Utente"%>
<%@include file="./include/Header.jsp" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.io.*" %>
<%@page import="com.pacchetto.servlets.Interesse" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
	<%
		
	%>
	<h1>Ciao utente <%=user %></h1>
	<%
		ResultSet rs_utente = Utente.getUtente(user);
		if(rs_utente.next()){
	    String percorsoImg = rs_utente.getString("immagine");
		
	%>
	<b><%=percorsoImg %></b>
	<img src=<%=percorsoImg %> alt="non funziona" />
	<form name="uploadForm" action="Uploader" method="post" enctype="multipart/form-data">
		<input type="file" name="file" value="" width="100" />
		<input type="submit" name="carica" value="carica" />
	</form>
	<h1><%=rs_utente.getString("email") %></h1>
	
	<div id="interessi" contenteditable="false" style="background-color: white;">
		<form name="scegliinteressi" method="post"> <!-- non c'era --> 
		<% 
			int contatore=1;
			ResultSet rs = Interesse.getInteressi();
			while(rs.next())
			{
		%>
		<input type="checkbox" name="interesse[]" value=<%=rs.getInt("id_interesse")%>  <%if(Interesse.checkinteresse(rs_utente.getInt("id"),rs.getInt("id_interesse"))){%> checked <%}%> > <label><%=rs.getString("nome") %></label><br>
		 <%
		  	contatore++;}
			rs.close();
		  %>
		  <%} %>
		</form> <!-- non c'era -->
	</div>

<%@include file="./include/Footer.jsp" %>