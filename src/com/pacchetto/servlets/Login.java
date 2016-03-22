package com.pacchetto.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jasypt.util.password.StrongPasswordEncryptor;

import com.mysql.jdbc.Connection;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Connection conn = null;
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// get request parameters for userID and password
				String user = request.getParameter("user_login");
				String pwd = request.getParameter("password_login");
				StrongPasswordEncryptor passwordEncryptor = new StrongPasswordEncryptor();
				//String pass_cripted = passwordEncryptor.encryptPassword(pwd);
				
				// query per prendere i parametri di login
				//String login_query ="SELECT id FROM utenti WHERE username=? and password=? LIMIT 1";
				String get_pwd = "SELECT password FROM utenti WHERE username=? LIMIT 1";
				
				try{
					conn = Connessione.getConnection();
					java.sql.PreparedStatement ps=conn.prepareStatement(get_pwd);
					ps.setString(1, user);
					ResultSet rs = ps.executeQuery();
					int controllo= rs.last() ? rs.getRow() : 0;
					if(controllo==1){
						String pwd_cripted = rs.getString(1);
						ps.close();
						if (passwordEncryptor.checkPassword(pwd, pwd_cripted)) {
				        	HttpSession session = request.getSession();
							session.setAttribute("user", user);
							//setting session to expire in 30 mins
							session.setMaxInactiveInterval(30*60);
							Cookie userName = new Cookie("user", user);
							userName.setMaxAge(30*60);
							response.addCookie(userName);
							response.sendRedirect("Home.jsp");

				        	} 
				        else {
				        	RequestDispatcher rd = getServletContext().getRequestDispatcher("/Index.jsp");
							PrintWriter out= response.getWriter();
							out.println("<script>alert('Password errata riscrivi la password!');"+
									    "window.location.href = 'Index.jsp';"+ "</script>");
							rd.include(request, response);
				        	}
					}
					else {
			        	RequestDispatcher rd = getServletContext().getRequestDispatcher("/Index.jsp");
						PrintWriter out= response.getWriter();
						out.println("<script>alert('Nome utente errato');"+
								    "window.location.href = 'Index.jsp';"+ "</script>");
						rd.include(request, response);
			        	}
				}
				catch(Exception e){
					e.printStackTrace();
					PrintWriter stampa= response.getWriter();
		        	RequestDispatcher rd = getServletContext().getRequestDispatcher("/Index.jsp");
		        	stampa.println("<script>alert('Database is down. Try later');"+
		        			       "window.location.href = 'Index.jsp';"+ "</script>");
		        	rd.include(request, response);
				}

	}

}
