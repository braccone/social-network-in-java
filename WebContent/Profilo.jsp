<%@page import="com.pacchetto.servlets.Connessione"%>
<%@page import="com.pacchetto.servlets.Utente"%>
<%@include file="./include/Header.jsp" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.io.*" %>
<%@page import="com.mysql.jdbc.Connection" %>
<%@page import="com.pacchetto.servlets.Interesse" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
	<%
		
	%>
	<h1>Ciao utente <%=user %></h1>
	<%
		Connection conn = Connessione.getConnection();
		ResultSet rs_utente = Utente.getUtente(user,conn);
		ResultSet rs_interesse = Interesse.getInteressi(conn);
		int id_utente=1;
		if(rs_utente.next()){
	    String percorsoImg = rs_utente.getString("immagine");	
		 //prendo l'id dell'utente
		 id_utente=rs_utente.getInt("id");

	%>
	<img src=<%=percorsoImg %> alt="non funziona" />
	<form name="uploadForm" action="Uploader" method="post" enctype="multipart/form-data">
		<input type="file" name="file" value="" width="100" accept="image/*" id="file"/>
		<input type="button" name="carica" value="carica" onclick="checkFile()"/>
	</form>
	<h1><%=rs_utente.getString("email") %></h1>
	
	<div id="interessi" contenteditable="false" style="background-color: white;">
		<form name="scegliinteressi" method="post"> <!-- non c'era --> 
		<% 
			int contatore=1;
			while(rs_interesse.next())
			{
				//se l'interesse è stato seguito allora lo stampa:
				if(Interesse.test_Interesseseguito(id_utente,rs_interesse.getInt("id_interesse")))
				{
			%>
			 <label><%=rs_interesse.getString("nome") %></label><br>
			<% 
				}
			}
			rs_interesse.close();}
		rs_utente.close();
			%>
			<input type="button" onclick="location.href='Interessi.jsp';" value="Modifica Interessi" />
		</form> <!-- non c'era -->

	</div>
	
	<div id="listaamici">
	<h1>Amici</h1>
	<a href="AggiungiAmico.jsp">Invia richiesta di amicizia</a>
		<%
		ResultSet rs = Utente.getAmici(id_utente,conn);
		if(rs!=null){
			while(rs.next())
			{
			%>
				<div id="Domande">
					<h2><a href="ProfiloEsterno.jsp?id=<%=rs.getInt("id")%>">
						<img alt="non funziona" height="50" width="50" src=<%=rs.getString("immagine")%> />
						<%=rs.getString("ut.username")%>
					</a></h2>
				</div>
			<%
			}
		}
		conn.close();
		%>
	</div>

<%@include file="./include/Footer.jsp" %>