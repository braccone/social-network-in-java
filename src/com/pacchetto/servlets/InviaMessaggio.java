package com.pacchetto.servlets;

import java.io.IOException;
import java.io.PrintWriter;
//import java.sql.PreparedStatement;
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


@WebServlet("/InviaMessaggio")
public class InviaMessaggio extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    public InviaMessaggio() {
        super();
    }
    Connection conn = null;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//variabili
		HttpSession session = request.getSession();
		String descrizione = request.getParameter("descrizione");
		int id_destinatario = Integer.parseInt(request.getParameter("destinatario"));
		String user = (String) session.getAttribute("user");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date utilDate = new Date();
        String data = dateFormat.format(utilDate);
        dateFormat = new SimpleDateFormat("HH:mm:ss");
        String ora = dateFormat.format(utilDate);
		
        PrintWriter stampa= response.getWriter();
		
		try{
			//RequestDispatcher rd = getServletContext().getRequestDispatcher("/InviaMessaggio?id="+id_destinatario+".jsp");
			if(user!=null){
				
				conn = Connessione.getConnection();
				
				//Inserimento del messaggio
				ResultSet rs = Utente.getUtente(user,conn);
				if(rs.next()){
					int id_mittente = rs.getInt("id");
					rs.close();
					Messaggio.invia_Messaggio(id_mittente, id_destinatario, descrizione, data, ora);
					stampa.println("<script>alert('Il messaggio e' stato inviato');"+"</script>");
					response.sendRedirect("MessaggioInviato.jsp");
				}
				conn.close();
			}
			else
			{
				response.sendRedirect("Index.jsp");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
}
