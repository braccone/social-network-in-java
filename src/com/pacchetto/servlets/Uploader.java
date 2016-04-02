package com.pacchetto.servlets;



import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
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
import java.util.regex.Pattern;


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

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//if(ext){
		HttpSession session = request.getSession();
		String user = (String) session.getAttribute("user");
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
	    String ext="";
	    for (Part part : parts){
	    	if(getExt(part) != null){
	        	ext=getExt(part);
	        	break;
	        }
	    }
	    if(ext.equals("png") || ext.equals("jpeg") || ext.equals("JPEG") || ext.equals("PNG") || ext.equals("jpg") || ext.equals("JPG") || ext.equals("BMP") || ext.equals("bmp")){
	        for (Part part : parts) {
	        	part.write(fileSaveDir+File.separator+getFileName(part, user));
	        }
	        ImageResize ir = new ImageResize();
	        try {
	              ir.resizeImage(new File(savePath+File.separator+user+".png"), savePath , 300, 300);
	        } catch (IOException ex) {
	              ex.printStackTrace();
	        }
	        //inserisco percorso immagine nel database
	        try {
				int i = Utente.updateImage("/img/"+user+".png", user);
				response.sendRedirect("Profilo.jsp");
				response.setHeader("REFRESH", "0");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	    else{
    		RequestDispatcher rd = getServletContext().getRequestDispatcher("/Profilo.jsp");
			PrintWriter out= response.getWriter();
			out.println("<script>alert('Il file che hai scelto non è un immagine!"+ext+"');"+
					    "window.location.href = 'Profilo.jsp';"+ "</script>");
			rd.include(request, response);
			return ;
    	}
    }
	private String getExt(Part part) {
        String partHeader = part.getHeader("content-disposition");
        String filename;
        String ext;
        for (String cd : partHeader.split(";")) {
            if (cd.trim().startsWith("filename")) {
            	filename = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            	String[] parts = filename.split(Pattern.quote("."));
            	ext = parts[1];
                return ext;//cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
 
    private String getFileName(Part part,String user) {
        String partHeader = part.getHeader("content-disposition");
        String filename;
        String ext;
        for (String cd : partHeader.split(";")) {
            if (cd.trim().startsWith("filename")) {
            	filename = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            	String[] parts = filename.split(Pattern.quote("."));
            	ext = parts[1];
                return user+".png";//cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
