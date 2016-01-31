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


@WebServlet("/Domanda")
public class Domanda extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    public Domanda() {
        super();
    }
    Connection conn = null;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//variabili
		HttpSession session = request.getSession();
		String titolo = request.getParameter("titolo");
		String descrizione = request.getParameter("descrizione");
		String[] select = request.getParameterValues("select[]");
		String user = (String) session.getAttribute("user");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date utilDate = new Date();
        String data = dateFormat.format(utilDate);
        dateFormat = new SimpleDateFormat("HH:mm:ss");
        String ora = dateFormat.format(utilDate);
        //query 
		String in_interessi = "INSERT INTO interesse_domanda VALUES (?,?)";
		
		PrintWriter stampa= response.getWriter();
		
		
		try{
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/Domanda.jsp");
			if(user!=null){
				
				conn = Connessione.getConnection();
				
				//SELECT per vedere se il titolo è univoco
				ResultSet rs = DomandaUtente.getIdDomanda(titolo);
				int max_titolo= rs.last() ? rs.getRow() : 0;
				stampa.println("<script>alert('"+rs.last()+"');window.location.href = 'Domanda.jsp';"+"</script>");
				rs.close();
		        if(max_titolo!=0){
		        	
		        	stampa.println("<script>alert('Domanda già posta. E possibile cercare la domanda nella sezione x');window.location.href = 'Domanda.jsp';"+"</script>");
		        	rd.include(request, response);
		        	rs.close();
		        }
		        else{
			        //SELECT dell'id dell'utente loggato
		        	rs = Utente.getUtente(user);
					int id=0;
					while(rs.next()){
						id=rs.getInt("id");
					}
					rs.close();
					//INSERT dei dati nella tabella domanda con id_domandante = id dell'utente loggato
					DomandaUtente.insertDomande(id, titolo, descrizione, data, ora);
					//Prende l'id della domanda inserita
					rs=DomandaUtente.getIdDomanda(titolo);
					int id_domanda=0;
					int k=0;
					while(rs.next()){
						id_domanda=rs.getInt("id_domanda");
					}
					//INSERT id interessi e id domanda in tabella interessi_domanda
					for(int j=0;j<select.length;j++){
						PreparedStatement ps=conn.prepareStatement(in_interessi);
						ps.setInt(1, Integer.parseInt(select[j]));
						ps.setInt(2, id_domanda);
						k=ps.executeUpdate();
						if(k>0){
							stampa.println("<script>alert('INTERESSI INSERITI NELLA TABELLA');window.location.href = 'Domanda.jsp';"+"</script>");
							rd.include(request, response);
						}
						ps.close();
					}
					
					
				}
			}
			else{
				response.sendRedirect("Index.jsp");
				}
			}
		catch(Exception e){
			e.printStackTrace();
		}
	}
}
