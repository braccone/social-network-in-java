package com.pacchetto.servlets;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;

public class Interesse {
	//Query per la raccolta di tutti gli interessi
	static String get_interessi="SELECT * FROM interesse";

	//Query che vede se un determinato interesse è seguito dall'utente
	static String test_interesseseguito="SELECT * FROM interesse_utenti WHERE id_persona = ? AND id_interesse = ?";
	
	//Forse da cancellare
	//Query che fa seguire un interesse ad un utente
	static String segui_interesse="INSERT INTO interesse_utenti VALUES(?,?)";
	
	//Query che toglie un interesse seguito
	static String deseleziona_interesse="DELETE FROM interesse_utenti WHERE id_persona=? AND id_interesse=?";
	
	//Query che elimina tutti gli interessi seguiti da un determinato utente
	static String delete_all_interessixutente="DELETE FROM interesse_utenti WHERE id_persona=?";
	
	//Ritorna tutti gli interessi esistenti
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

	//Ritorna true se l'interesse è seguito dall'utente altrimenti ritorna false
	public static Boolean test_Interesseseguito(int id_persona,int id_interesse) throws SQLException{
		Connection conn= null;
		try{
			conn= Connessione.getConnection();
			java.sql.PreparedStatement ps=conn.prepareStatement(test_interesseseguito);
			ps.setInt(1, id_persona);
			ps.setInt(2, id_interesse);
	        ResultSet rs = ps.executeQuery();
	        if(rs.next()){
	        	return true;
	        }
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
	
	//Forse da cancellare
	//Inserisce nel database l'interesse selezionato dall'utente
	public static Boolean Segui_interesse(int id_persona,int id_interesse) throws SQLException{
		Connection conn= null;
		try{
			conn= Connessione.getConnection();
			java.sql.PreparedStatement ps=conn.prepareStatement(segui_interesse);
			ps.setInt(1, id_persona);
			ps.setInt(2, id_interesse);
	        ps.executeUpdate();
	        conn.commit(); //non c'era, è un test
	        return true;
	        
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
	
	public static Boolean Deselect_interesse(int id_persona,int id_interesse) throws SQLException{
		Connection conn= null;
		try{
			conn= Connessione.getConnection();
			java.sql.PreparedStatement ps=conn.prepareStatement(deseleziona_interesse);
			ps.setInt(1, id_persona);
			ps.setInt(2, id_interesse);
	        ps.executeUpdate();
	        conn.commit(); //non c'era, è un test
	        return true;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
	
	public static Boolean DeleteAllInteresseXPersona(int id_persona) throws SQLException{
		Connection conn= null;
		try{
			conn= Connessione.getConnection();
			java.sql.PreparedStatement ps=conn.prepareStatement(delete_all_interessixutente);
			ps.setInt(1, id_persona);
	        ps.executeUpdate();
	        conn.commit(); //non c'era, è un test
	        return true;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
}
