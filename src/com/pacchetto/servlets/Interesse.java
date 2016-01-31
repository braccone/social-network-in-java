package com.pacchetto.servlets;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;

public class Interesse {
	static String get_interessi="SELECT * FROM interesse";

	 
	public static ResultSet getInteressi() throws SQLException{
		Connection conn= null;
		try{
			conn= Connessione.getConnection();
			java.sql.PreparedStatement ps=conn.prepareStatement(get_interessi);

	        ResultSet rs = ps.executeQuery();
	     
			return rs;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}

}
