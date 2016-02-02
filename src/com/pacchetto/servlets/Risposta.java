package com.pacchetto.servlets;

import java.io.IOException;
import java.io.PrintWriter;
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

/**
 * Servlet implementation class Risposta
 */
@WebServlet("/Risposta")
public class Risposta extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Risposta() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String user = (String) session.getAttribute("user");
		String id_domanda = request.getParameter("prova");
		String testo = request.getParameter("risposta");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date utilDate = new Date();
        String data = dateFormat.format(utilDate);
        dateFormat = new SimpleDateFormat("HH:mm:ss");
        String ora = dateFormat.format(utilDate);
        
        PrintWriter stampa= response.getWriter();
        try{
        	
        	RequestDispatcher rd = getServletContext().getRequestDispatcher("/Risposta.jsp?id="+id_domanda);
        	if(user!=null ){
        		ResultSet rs = Utente.getUtente(user);
        		int id_utente=0;
        		while(rs.next()){
        		id_utente = rs.getInt("id");
        		}
        		
        		int k= RisposteUtente.insertRisposta(id_domanda, id_utente, testo, data, ora);
        		if(k>0){
					stampa.println("<script>alert('Risposta Inserita nel database');window.location.href = 'Risposta.jsp?id="+id_domanda+"';"+"</script>");
					rd.include(request, response);
				}
        	}
        	else{
        		response.sendRedirect("Risposta.jsp?id="+id_domanda);
        	}
        }
        catch(Exception e){
        	e.printStackTrace();
        	response.sendRedirect("Risposta.jsp?id="+id_domanda);
        }
	}

}
