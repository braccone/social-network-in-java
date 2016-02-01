package com.pacchetto.servlets;

//import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

//import javax.servlet.RequestDispatcher;

import com.mysql.jdbc.Connection;

public class Utente {
	//query che ritorna tutti i dati dell'utente scelto
	static String get_utente="SELECT * FROM utenti WHERE username=?";
	
	//query che ritorna tutti gli amici dell'utente
	static String get_amici="SELECT ut.* FROM utenti AS ut, amico AS am WHERE (am.id_richiedente=? OR am.id_ricevente=?) AND ut.id != ? AND accettato = 'true'";
	
	//query che ritorna tutte le richieste di amicizia ricevute dall'utente
	static String get_pendingrequests="SELECT ut.* FROM utenti AS ut, amico AS am WHERE am.id_ricevente = ? AND am.id_richiedente=ut.id AND accettato = 'false'";
	
	//query che ritorna tutte le richieste di amicizia inviate dall'utente
	static String get_richiesta="SELECT ut.* FROM utenti AS ut, amico AS am WHERE am.id_richiedente=? AND am.id_ricevente=ut.id AND accettato = 'false'";
	
	//query che inserisce l'utente nel database
	static String insert_utente = "INSERT INTO utenti VALUES (0,?,?,?,?,'0')";
	
	//Metodo che ritorna tutti i dati dell'utente una volta datogli il nome
	public static ResultSet getUtente(String nomeutente) throws SQLException{
		Connection conn= null;
		try{
			conn= Connessione.getConnection();
			java.sql.PreparedStatement ps=conn.prepareStatement(get_utente);
			ps.setString(1, nomeutente);
	        ResultSet rs = ps.executeQuery();
			return rs;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	//Metodo per l'inserimento dell'utente nel database
	public static int insertUtente(String nickname,String email,String pass_cripted,String data) throws SQLException{
		Connection conn= null;
		try{
			conn= Connessione.getConnection();
			java.sql.PreparedStatement ps = conn.prepareStatement(insert_utente);
	        ps.setString(1, nickname);
	        ps.setString(2, email);
	        ps.setString(3, pass_cripted);
	        ps.setString(4, data);
	        int i = ps.executeUpdate();
	        if(i>0){
	        	//prova avvenuta registrazione
	        	return i;
	        	}
	        ps.close();
	        return 0;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return 0;
	}
	//Metodo che ritorna gli Amici dell'utente
	public static ResultSet getAmici(int id_utente){
		Connection conn= null;
		try{
			conn= Connessione.getConnection();
			java.sql.PreparedStatement ps=conn.prepareStatement(get_amici);
			ps.setInt(1, id_utente);
			ps.setInt(2, id_utente);
			ps.setInt(3, id_utente);
	        ResultSet rs = ps.executeQuery();
			return rs;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	//Metodo che ritorna un result set contenente l'insieme delle richieste di amicizia inoltrate all'utente
	public static ResultSet getFriendReq(int id_utente){
		Connection conn= null;
		try{
			conn= Connessione.getConnection();
			java.sql.PreparedStatement ps=conn.prepareStatement(get_pendingrequests);
			ps.setInt(1, id_utente);
	        ResultSet rs = ps.executeQuery();
			return rs;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	//Ritorna un result set con l'insieme degli utenti ai quali sono state inviate
	//richieste di amicizia da parte dell'utente
	public static ResultSet getRichieste(int id_utente){
		Connection conn= null;
		try{
			conn= Connessione.getConnection();
			java.sql.PreparedStatement ps=conn.prepareStatement(get_richiesta);
			ps.setInt(1, id_utente);
	        ResultSet rs = ps.executeQuery();
			return rs;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
}