package com.pacchetto.servlets;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.mysql.jdbc.Connection;

public class RisposteUtente {
	 //attributi
	//Query che ricerca le risposte fatte dall'utente
	static String get_risposte="SELECT risp.* FROM risposta AS risp, utenti AS ut WHERE risp.id_rispondente=ut.id AND ut.id=? ORDER BY data DESC";
	
	//Query che ricerca le risposte ad una determinata domanda
	static String get_rispostedomanda="SELECT risp.* FROM risposta AS risp, domanda AS dm WHERE risp.id_risposta = dm.id_domanda AND dm.id_domanda=?";
	
	//Query che inserisce la risposta nel database
	static String insert_risposta="INSERT INTO risposta VALUES(0,?,?,?,?,false,?)";
	
	//metodi
	public static ResultSet getRisposteUtente(int id_domandante){
		try {
			Connection conn= Connessione.getConnection();
			PreparedStatement ps = conn.prepareStatement(get_risposte);
			ps.setInt(1, id_domandante);
			ResultSet rs = ps.executeQuery();
			return rs;
			
			}catch (Exception e) {
			
				e.printStackTrace();
				return null;
			}
	}
	
	public static ResultSet getRisposteDomande(String id_domanda){
		try {
			Connection conn= Connessione.getConnection();
			PreparedStatement ps = conn.prepareStatement(get_rispostedomanda);
			ps.setString(1, id_domanda);
			ResultSet rs = ps.executeQuery();
			return rs;
			
			}catch (Exception e) {
			
				e.printStackTrace();
				return null;
			}
	}
	
	public static int insertRisposta(String id_domanda,int id_utente,String testo,String data,String ora){
		try {
			Connection conn= Connessione.getConnection();
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
	}
}
