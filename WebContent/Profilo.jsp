<%@page import="com.pacchetto.servlets.Utente"%>
<%@include file="./include/Header.jsp" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.io.*" %>
<%@page import="com.pacchetto.servlets.Interesse" %>
	<%
		
	%>
	<h1>Ciao utente <%=user %></h1>
	<%
		ResultSet rs_utente = Utente.getUtente(user);
		rs_utente.next();
		File image = new File("./img/"+user+".png");
		image.getParentFile().mkdirs(); 
		image.createNewFile();
	    FileOutputStream fos = new FileOutputStream(image);
	    byte[] buffer = new byte[1024];
	    InputStream is = rs_utente.getBinaryStream("immagine");
	    while(is.read(buffer) > 0){
	    	fos.write(buffer);
	    }
	    fos.close();
	    String percorsoImg = "./img/"+user+".png";
	%>
	<b><%=percorsoImg %></b>
	<img src=<%=percorsoImg %> alt="non funziona">
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
		</form> <!-- non c'era -->
	</div>

<%@include file="./include/Footer.jsp" %>