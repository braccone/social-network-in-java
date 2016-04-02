package com.pacchetto.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
//import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
//import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
//import org.jasypt.util.*;
import org.jasypt.util.password.StrongPasswordEncryptor;

import com.mysql.jdbc.Connection;
//import com.mysql.jdbc.PreparedStatement;
/**
 * Servlet implementation class Registrazione
 */
@WebServlet("/Registrazione")
public class Registrazione extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    Connection conn = null;
    //Statement stmt = null;
    /**
     * Default constructor. 
     */
    public Registrazione() {

    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
        //PrintWriter out = response.getWriter();
		
        String nickname=request.getParameter("username");
        String email=request.getParameter("email");
        String pass=request.getParameter("password");
        StrongPasswordEncryptor passwordEncryptor = new StrongPasswordEncryptor();
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date utilDate = new Date();
        String data = dateFormat.format(utilDate);


        String pass_cripted = passwordEncryptor.encryptPassword(pass);

        
        try {
        	if((pass!="" || pass!=null || pass!="undefined") && (nickname != "" || nickname!=null || nickname != "undefined" ) && (email != "" || email != null || email!="undefined")){
        		conn = Connessione.getConnection();
        		ResultSet rs = Utente.getUtente(nickname,conn);
		        int max_users= rs.last() ? rs.getRow() : 0;
		        rs.close();
		        if(max_users != 0){
		        	//Inserisci l'inserimento dei dati nel database
		        	
		        	RequestDispatcher rd = getServletContext().getRequestDispatcher("/Index.jsp");
					PrintWriter stampa= response.getWriter();
					stampa.println("<script>alert('Il nome utente già in utilizzo');"
									+"document.modulo.username.value='';"
									+ "document.modulo.username.focus();window.location.href = 'Index.jsp';" + "</script>");
					rd.include(request, response);
		        }
		        else{
		        	int i =  Utente.insertUtente(nickname,email,pass_cripted,data);
			        if(i>0){
			        	//prova avvenuta registrazione
			        	PrintWriter stampa= response.getWriter();
			        	RequestDispatcher rd = getServletContext().getRequestDispatcher("/Index.jsp");
			        	stampa.println("<script>alert('Registrazione avvenuta');"+ "window.location.href = 'Index.jsp';"+"</script>");
			        	rd.include(request, response);
			        	}
		        	
		        }
		        conn.close();
	        }
        	else{
        		PrintWriter stampa= response.getWriter();
	        	RequestDispatcher rd = getServletContext().getRequestDispatcher("/Index.jsp");
	        	stampa.println("<script>alert('C'è un errore negli input dei campi riprova a inserirli correttamente');"
					+"document.modulo.username.value='';"
					+ "document.modulo.username.focus();" +"window.location.href = 'Index.jsp';"+ "</script>");
	        	rd.include(request, response);
        	}


        } catch (SQLException e1) {
            e1.printStackTrace();
            PrintWriter stampa= response.getWriter();
        	RequestDispatcher rd = getServletContext().getRequestDispatcher("/Index.jsp");
        	stampa.println("<script>alert('Database is down. Try later');window.location.href = 'Index.jsp';</script>");
        	rd.include(request, response);
        }

	}

}