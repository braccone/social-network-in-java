package com.pacchetto.servlets;

import java.io.IOException;
import java.io.PrintWriter;
//import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher; //lu dispaccer
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.Connection;


@WebServlet("/InteressiUtente")
public class InteressiUtente extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    public InteressiUtente() {
        super();
    }
    Connection conn = null;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		//variabili
		HttpSession session = request.getSession();
		String[] select = request.getParameterValues("select[]");
		//String[] deselect = request.getParameterValues("deselect[]");
		String user = (String) session.getAttribute("user");
		int id=0;
		int lunghezza=select.length;
		
		PrintWriter stampa= response.getWriter();  //Non c'era
		
		try{
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/Interessi.jsp"); //ce serve?
						
			if(user!=null){
				//Seleziono l'id dell'utente
				ResultSet rs;
	        	rs = Utente.getUtente(user);
				rs.next();
				id=rs.getInt("id");
				rs.close();
				
				//test per vedere se entra veramente, da cancellare
				stampa.println("<script>alert('select length adee "+lunghezza+"');</script>");
				rd.include(request, response);
	        	//////////////////////////////////
				
				conn = Connessione.getConnection();
				
				// INIZIO CON L'ELIMINARE TUTTI GLI INTERESSI SEGUITI DALL'UTENTE
				//boolean successo=Interesse.DeleteAllInteresseXPersona(id);
				Interesse.DeleteAllInteresseXPersona(id);
				//////////////////////////////////////////
				

				//Inserimento nel database degli elementi selezionati
				for(int j=0;j<lunghezza;j++){
						Interesse.Segui_interesse(id,Integer.parseInt(select[j]));
					}
				response.sendRedirect("Interessi.jsp");
			}else{
				response.sendRedirect("Index.jsp");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
}
