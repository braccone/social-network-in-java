package com.pacchetto.servlets;

import java.sql.DriverManager;
import java.sql.SQLException;
//import java.util.Properties;

import com.mysql.jdbc.Connection;

public class Connessione {

	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/social";
    static final String USER = "root";
    static final String PASS = "password";

	public static Connection getConnection() throws SQLException {

	    Connection conn = null;
	    try{
	    Class.forName("com.mysql.jdbc.Driver");
        conn = (Connection) DriverManager.getConnection(DB_URL, USER, PASS);
	    }
	    catch(Exception e){
	    	e.printStackTrace();
	    }
	 
	    return conn;
	}
}
