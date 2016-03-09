package com.pacchetto.servlets;



import java.io.File;
import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import java.sql.SQLException;
import java.util.Collection;


/**
 * Servlet implementation class Uploader
 */
@WebServlet("/Uploader")
@MultipartConfig
public class Uploader extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Uploader() {
        super();
        // TODO Auto-generated constructor stub
    }
    private static final String SAVE_DIR = "img";
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    /*protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
 
        getServletContext().getRequestDispatcher("Profilo.jsp").forward(request, response);
    }*/
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String user = (String) session.getAttribute("user");
		//PrintWriter out = response.getWriter();
		// gets absolute path of the web application
        String appPath = request.getServletContext().getRealPath("");
        // constructs path of the directory to save uploaded file
        String savePath = appPath + SAVE_DIR;
         
        // creates the save directory if it does not exists
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }
        Collection<Part> parts = request.getParts();
 
        for (Part part : parts) {
            part.write(fileSaveDir+File.separator+getFileName(part, user));
        }
        ImageResize ir = new ImageResize();
        try {
              ir.resizeImage(new File(fileSaveDir+File.separator+user+".png"), "/img/", 300, 300);
        } catch (IOException ex) {
              ex.printStackTrace();
        }
        //inserisco percorso immagine nel database
        try {
			int i = Utente.updateImage("/img/"+user+".png", user);
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }
 
 
    private String getFileName(Part part,String user) {
        String partHeader = part.getHeader("content-disposition");
        for (String cd : partHeader.split(";")) {
            if (cd.trim().startsWith("filename")) {
                return user+".png";//cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
