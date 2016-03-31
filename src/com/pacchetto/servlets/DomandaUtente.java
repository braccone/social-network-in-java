package com.pacchetto.servlets;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;

public class DomandaUtente {
	//attributi
	//Query che ricerca le domande fatte dall'utente
	static String get_domande="SELECT * FROM domanda WHERE id_domandante =? ORDER BY data DESC,ora DESC";
	
	//Query che restituisce la domanda per id domanda
	static String get_domanda="SELECT * FROM domanda WHERE id_domanda =?";
	
	//Query che ricerca le domande che hanno almeno un interesse in comune a quelli seguiti dall'utente e le ordina in base alla data in maniera decrescente
	//Aggiornamento: prima al posto di SELECT * c'era SELECT dm.*
	static String get_domandeInteressiP="SELECT * FROM domanda AS dm,interesse_domanda AS ixd,interesse AS itr,interesse_utenti AS ixp, utenti AS ut WHERE ixp.id_persona=ut.id AND ixp.id_interesse=itr.id_interesse AND itr.id_interesse = ixd.id_interesse AND ixd.id_domanda=dm.id_domanda AND ut.id=? ORDER BY dm.data DESC";
	
	//Query che ricerca le domande relative ad un certo interesse
	static String get_domandeInteresse="SELECT dm.* FROM domanda AS dm, interesse_domanda AS ixd, interesse AS itr WHERE itr.id_interesse = ixd.id_interesse AND ixd.id_domanda = dm.id_domanda AND itr.nome = ?";

	//Query per l'inserimento della domanda
	static String insert_domanda="INSERT INTO domanda VALUES (0,?,?,?,?,0,?)";
	
	//Query che restituisce id domanda dato il titolo.
	static String get_iddomanda="SELECT id_domanda FROM domanda WHERE titolo=?";
	
	//Query che restituisce tutte le domande
	static String get_tutto="SELECT * FROM domanda as dom,utenti as ut WHERE dom.id_domandante=ut.id ORDER BY data DESC,ora DESC";
	 
	//prende tutte le domande che contengono la stringa 
	static String get_domandastringa="SELECT * FROM domanda WHERE titolo LIKE ? ORDER BY data DESC,ora DESC"; //c'erano le ' ' prima e dopo %?% e non c'era neo
	
	//Query che ritorna chi ha fatto una determinata domanda datogli l'id della domanda
	static String get_domandante="SELECT ut.* FROM utenti AS ut, domanda as dm WHERE ut.id=dm.id_domandante AND dm.id_domanda=?";
		 
	//Query che ritorna tutte le domande poste dagli amici e quelle pertinenti agli interessi da te seguiti
	static String get_domandeamicointeresse="SELECT dm.* FROM domanda AS dm,interesse_domanda AS ixd,interesse AS itr,interesse_utenti AS ixp, utenti AS ut, amico AS am WHERE (ixp.id_persona=ut.id AND ixp.id_interesse=itr.id_interesse AND itr.id_interesse = ixd.id_interesse AND ixd.id_domanda=dm.id_domanda AND ut.id=?) UNION SELECT distinct dm.* FROM utenti as ut,amico as am,domanda as dm WHERE (dm.id_domandante=ut.id AND ut.id=?) OR (((dm.id_domandante=am.id_richiedente OR dm.id_domandante = am.id_ricevente) AND (ut.id=am.id_richiedente OR ut.id=am.id_ricevente)) AND am.accettato = 1 AND ut.id=?) ORDER BY data DESC, ora DESC";
		 
	//METODI
	 
	//ritorna tutte le domande ed i loro rispettivi creatori

	public static ResultSet getTutto(Connection conn){
		try {
			PreparedStatement ps = conn.prepareStatement(get_tutto);
			ResultSet rs = ps.executeQuery();
			return rs;
			}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	//Ritorna l'insieme delle domande dato l'id domandante
	public static ResultSet getDomande(int id_domandante,Connection conn){
		try {
			PreparedStatement ps = conn.prepareStatement(get_domande);
			ps.setInt(1, id_domandante);
			ResultSet rs = ps.executeQuery();
			return rs;
			
			}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	//Ritorna il la domanda che ha come id quello datogli
	public static ResultSet getDomanda(String id_domanda,Connection conn){
		try {
			PreparedStatement ps = conn.prepareStatement(get_domanda);
			ps.setString(1, id_domanda);
			ResultSet rs = ps.executeQuery();
			return rs;
			
			}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	//Ritorna l'id di una domanda datogli il titolo
	public static ResultSet getIdDomanda(String titolo,Connection conn){
		try {
			PreparedStatement ps = conn.prepareStatement(get_iddomanda);
			ps.setString(1, titolo);
			ResultSet rs = ps.executeQuery();
			return rs;
			
			}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
		
	//Ritorna le domande che possono interessare all'utente

	public static ResultSet getDomandeInteresseP(int id_domandante,Connection conn){
		try {
			PreparedStatement ps = conn.prepareStatement(get_domandeInteressiP);
			ps.setInt(1, id_domandante);
			ResultSet rs = ps.executeQuery();
			return rs;	
			}
		catch (Exception e) {
				e.printStackTrace();
				return null;
			}
		}
	//Ritorna tutte le domande che hanno come interesse quello che ha il nome dato come argomento
	public static ResultSet getDomandeInteresse(String nome,Connection conn){
		try {
			PreparedStatement ps = conn.prepareStatement(get_domandeInteresse);
			ps.setString(1, nome);
			ResultSet rs = ps.executeQuery();
			return rs;		
			}
		catch (Exception e){
			e.printStackTrace();
			return null;
		}
	}
	//Inserisce una determinata domanda nel database
	public static void insertDomande(int id_domandante,String titolo,String descrizione,String data,String ora ) throws SQLException{
		Connection conn=null;
		try {
			conn= Connessione.getConnection();
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
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
	}
		
	//prende le domande che hanno nel loro titolo la stringa data
	public static ResultSet getDomandeStringa(String titolo,Connection conn){
		try {
			PreparedStatement ps = conn.prepareStatement(get_domandastringa);
			ps.setString(1,"%"+ titolo + "%");
			ResultSet rs = ps.executeQuery();
			return rs;
			
			}catch (Exception e) {
				e.printStackTrace();
				return null;
			}
	}
	
	//ritorna il domandante
	public static ResultSet getDomandante(int id_domanda,Connection conn) throws SQLException{
		try {
			PreparedStatement ps = conn.prepareStatement(get_domandante);
			ps.setInt(1, id_domanda);
			ResultSet rs = ps.executeQuery();
			return rs;
		}
		catch (Exception e)
		{
			e.printStackTrace();
			return null;
		}
	}
	
	public static ResultSet getDomandeAmicoInteressi(int id_utente,Connection conn) throws SQLException{
		try {
			PreparedStatement ps = conn.prepareStatement(get_domandeamicointeresse);
			ps.setInt(1, id_utente);
			ps.setInt(2, id_utente);
			ps.setInt(3, id_utente);
			ResultSet rs = ps.executeQuery();
			return rs;
						
			}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
