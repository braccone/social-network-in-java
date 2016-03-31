<%@page import="com.pacchetto.servlets.Utente"%>
<%@include file="./include/Header.jsp" %>
	<%@page import="java.sql.ResultSet" %>
	<%@page import="com.pacchetto.servlets.Interesse" %>
	<%@page import="com.pacchetto.servlets.DomandaUtente" %>
	<%@page import="com.pacchetto.servlets.InteressiUtente" %>
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
			<h1>Interessi</h1>
			<%
			ResultSet rs;
			rs = Utente.getUtente(user);
			int id_utente = 0;
			while(rs.next()){
				id_utente = rs.getInt("id");
			}
			rs.close();
			
			//devo prendere tutti gli interessi ed inserirli nel resultset
			rs = Interesse.getInteressi();
			//ciclo while che stampa tutti gli interessi
			%>
			<form name="forminteresse" method="post">
			<%
			while(rs.next())
			{
			%>
			
			<div id="Interessi">
				<div id="Interesse">
					
						<h2> <%=rs.getString("nome")%>
						<% //se l'interesse è seguito dall'utente allora può solo toglierlo mentre
				   		//se non lo è può solo seguirlo
						if(Interesse.test_Interesseseguito(id_utente,rs.getInt("id_interesse")))
						{
						%>      
							<input type="checkbox" name="interesse[]" value=<%=rs.getInt("id_interesse")%> checked style="display: inline;"/><br>
						<%	
						}else
						{
						%>		
							<input type="checkbox" name="interesse[]" value=<%=rs.getInt("id_interesse")%> style="display: inline;"/><br>
						<%		
						}
					%>
						</h2>
				</div>
			</div>
			<%
			}
			rs.close();
			%>
			<input type="button" name="inserisci" value="inserisciinteressi" onClick="seguiinteressi()"/>
			</form>
		</div>
<%@include file="./include/Footer.jsp" %>