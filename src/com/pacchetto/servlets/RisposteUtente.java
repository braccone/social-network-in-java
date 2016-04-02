package com.pacchetto.servlets;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;

public class RisposteUtente {
	 //attributi
	//Query che ricerca le risposte fatte dall'utente
	static String get_risposte="SELECT risp.* FROM risposta AS risp, utenti AS ut WHERE risp.id_rispondente=ut.id AND ut.id=? ORDER BY data DESC";
	
	//Query che ricerca le risposte ad una determinata domanda
	static String get_rispostedomanda="SELECT risp.* FROM risposta AS risp, domanda AS dm WHERE risp.id_domanda = dm.id_domanda AND dm.id_domanda=?";
	
	//Query che inserisce la risposta nel database
	static String insert_risposta="INSERT INTO risposta VALUES(0,?,?,?,?,?,0)";
	
	//Query che ritorna i dati dell'utente che ha risposto ad una domanda
	static String get_utente="SELECT ut.* FROM utenti as ut,risposta as ri WHERE ut.id = ri.id_rispondente and ri.id_rispondente=?";
	//metodi
	public static ResultSet getRisposteUtente(int id_domandante,Connection conn){
		try {
			PreparedStatement ps = conn.prepareStatement(get_risposte);
			ps.setInt(1, id_domandante);
			ResultSet rs = ps.executeQuery();
			return rs;
			
			}catch (Exception e) {
			
				e.printStackTrace();
				return null;
			}
	}
	
	public static ResultSet getRisposteDomande(String id_domanda,Connection conn){
		try {
			PreparedStatement ps = conn.prepareStatement(get_rispostedomanda);
			ps.setString(1, id_domanda);
			ResultSet rs = ps.executeQuery();
			return rs;
			
			}catch (Exception e) {
			
				e.printStackTrace();
				return null;
			}
	}
	
	public static int insertRisposta(String id_domanda,int id_utente,String testo,String data,String ora) throws SQLException{
		Connection conn=null;
		try {
			conn= Connessione.getConnection();
			PreparedStatement ps = conn.prepareStatement(insert_risposta);
			ps.setString(1, id_domanda);
			ps.setInt(2, id_utente);
			ps.setString(3, testo);
			ps.setString(4, data);
			ps.setString(5, ora);
			int i = ps.executeUpdate();
			return i;
			
			}catch (Exception e) {
			
				e.printStackTrace();
				return 0;
			}
		finally{
			conn.close();
		}
	}
	
	public static ResultSet getUtente(int id_utente,Connection conn){
		try {
			PreparedStatement ps = conn.prepareStatement(get_utente);
			ps.setInt(1, id_utente);
			ResultSet rs=ps.executeQuery();
			return rs;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
	}
	
}
