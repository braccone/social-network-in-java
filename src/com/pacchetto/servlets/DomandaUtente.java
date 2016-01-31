package com.pacchetto.servlets;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.mysql.jdbc.Connection;

public class DomandaUtente {
	 //attributi
	//Query che ricerca le domande fatte dall'utente
	static String get_domande="SELECT * FROM domanda WHERE id_domandante =? ORDER BY data DESC,ora DESC";
	
	//Query che ricerca le domande che hanno almeno un interesse in comune a quelli seguiti dall'utente e le ordina in base alla data in maniera decrescente
	 static String get_domandeInteressiP="SELECT dm.* FROM domanda AS dm,interesse_domanda AS ixd,interesse AS itr,interesse_utenti AS ixp, utenti AS ut WHERE ixp.id_persona=ut.id AND ixp.id_interesse=itr.id_interesse AND itr.id_interesse = ixd.id_interesse AND ixd.id_domanda=dm.id_domanda AND ut.id=? ORDER BY dm.data DESC";
	
	 //Query che ricerca le domande relative ad un certo interesse
	 static String get_domandeInteresse="SELECT dm.* FROM domanda AS dm, interesse_domanda AS ixd, interesse AS itr WHERE itr.id_interesse = ixd.id_interesse AND ixd.id_domanda = dm.id_domanda AND itr.nome = ?";
	
	 //Query per l'inserimento della domanda
	 static String insert_domanda="INSERT INTO domanda VALUES (0,?,?,?,?,0,?)";
	 
	 static String get_iddomanda="SELECT id_domanda FROM domanda WHERE titolo=?";
	 
	//metodi
	public static ResultSet getDomande(int id_domandante){
		try {
			Connection conn= Connessione.getConnection();
			PreparedStatement ps = conn.prepareStatement(get_domande);
			ps.setInt(1, id_domandante);
			ResultSet rs = ps.executeQuery();
			return rs;
			
			}catch (Exception e) {
			
				e.printStackTrace();
				return null;
			}
	}
	
	public static ResultSet getIdDomanda(String titolo){
		try {
			Connection conn= Connessione.getConnection();
			PreparedStatement ps = conn.prepareStatement(get_iddomanda);
			ps.setString(1, titolo);
			ResultSet rs = ps.executeQuery();
			return rs;
			
			}catch (Exception e) {
			
				e.printStackTrace();
				return null;
			}
	}
		
		//Ritorna le domande che possono interessare all'utente
	public static ResultSet getDomandeInteresseP(int id_domandante){
		try {
				Connection conn= Connessione.getConnection();
				PreparedStatement ps = conn.prepareStatement(get_domandeInteressiP);
				ps.setInt(1, id_domandante);
				ResultSet rs = ps.executeQuery();
				return rs;
				
			} catch (Exception e) {
				
				e.printStackTrace();
				return null;
			}
		}
		
	public static ResultSet getDomandeInteresse(String nome){
		try {
				Connection conn= Connessione.getConnection();
				PreparedStatement ps = conn.prepareStatement(get_domandeInteressiP);
				ps.setString(1, nome);
				ResultSet rs = ps.executeQuery();
				return rs;
					
			} catch (Exception e) {
					
				e.printStackTrace();
				return null;
			}
	}
	
	public static void insertDomande(int id_domandante,String titolo,String descrizione,String data,String ora ){
		try {
			Connection conn= Connessione.getConnection();
			PreparedStatement ps = conn.prepareStatement(insert_domanda);
			ps.setInt(1, id_domandante);
			ps.setString(2, titolo);
			ps.setString(3, descrizione);
			ps.setString(4, data);
			ps.setString(5, ora);
			int i= ps.executeUpdate();
			if(i>0){
	        	//Qui dobbiamo mettere qualcosa per far capire all'utente che la domanda è stata inserita
			}
			
			}catch (Exception e) {
			
				e.printStackTrace();
			}
	}
	
	
}
