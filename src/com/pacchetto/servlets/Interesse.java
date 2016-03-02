package com.pacchetto.servlets;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;

public class Interesse {
	
	//Query che ritorna tutti gli interessi
	static String get_interessi="SELECT * FROM interesse";
	
	//Query che ritorna l'interesse selezionato dall'utente
	static String get_interesse="SELECT * FROM interesse_utenti AS ixu WHERE ixu.id_persona=? and ixu.id_interesse=?";
	 
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

	//Metodo che ritorna true se l'interesse è seguito dall'utente e false se non lo è
	public static boolean checkinteresse(int idutente,int idinteresse) throws SQLException{
		Connection conn= null;
		try{
			conn= Connessione.getConnection();
			java.sql.PreparedStatement ps=conn.prepareStatement(get_interesse);
			ps.setInt(1, idutente);
			ps.setInt(2, idinteresse);

	        ResultSet rs = ps.executeQuery();
	        //Se c'è almeno un elemento allora ritorna TRUE
	        if(rs.first()){
	        	return true;
	        }
	        //in caso contrario ritorna false
			return false;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
}
