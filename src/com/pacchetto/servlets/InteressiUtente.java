package com.pacchetto.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
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
		String[] deselect = request.getParameterValues("deselect[]");
		String user = (String) session.getAttribute("user");
		int id=0;
		//query per l'inserimento degli interessi nel database
		String in_interessi = "INSERT INTO interesse_utenti VALUES (?,?)";
		//query per il deselezionamento degli interessi nel database
		String del_interessi="DELETE * FROM interesse_utenti WHERE id_persona=? AND id_interesse=?"; //da implementare
		
		try{
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/Interessi.jsp");
			if(user!=null){
				//Seleziono l'id dell'utente
				ResultSet rs;
	        	rs = Utente.getUtente(user);
				rs.next();
				id=rs.getInt("id");
				rs.close();
			}
				
				conn = Connessione.getConnection();
					//Inserimento nel database degli elementi selezionati
					for(int j=0;j<select.length;j++){
						PreparedStatement ps=conn.prepareStatement(in_interessi);
						ps.setInt(1, Integer.parseInt(select[j]));
						ps.setInt(2, id);
						ps.executeUpdate();
						ps.close();
					}
					
					//Eliminazione degli elementi non selezionati dal database
					//*
					/////
					
					
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
}
