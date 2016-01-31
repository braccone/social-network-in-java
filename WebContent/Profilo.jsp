<%@include file="./include/Header.jsp" %>

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
	<div>
	<h2>Ciao utente <%=user %></h2>
	</div>
<%@include file="./include/Footer.jsp" %>