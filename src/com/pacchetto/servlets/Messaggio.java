package com.pacchetto.servlets;

//import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

//import javax.servlet.RequestDispatcher;

import com.mysql.jdbc.Connection;

public class Messaggio {
	
	//QUERY
	//I punti di domanda sono rispettivamente id_mittente,id_destinatario,testo,data
	static String invia_messaggio="INSERT INTO messaggio VALUES(0,?,?,'',?,?,'false')";
	
	//Query che ritorna il messaggio se � stato letto
	static String check_letto="SELECT * FROM messaggio WHERE id_messaggio=? AND letto='true'";
	
	//Query che considera un determinato messaggio come visualizzato
	static String leggi_messaggio="UPDATE messaggio SET letto='true' WHERE id_messaggio=?";
	
	//Query che ritorna tutti i messaggi ricevuti da un utente che non sono stati ancora mai letti
	static String messaggi_non_letti="SELECT * FROM messaggio WHERE id_destinatario=? AND letto='false'";
	
	//Query che inserisce in tutti i messaggi ricevuti dall'utente il valore letto
	static String leggi_tutti_messaggi="UPDATE messaggio SET letto='true' WHERE id_destinatario=?";
	
	//Query che ritorna tutti i messaggi ricevuti in ordine decrescente di data
	static String get_messaggiricevuti="SELECT * FROM messaggio WHERE id_destinatario=? ORDER BY data DESC";
	
	//Query che ritorna tutti i messaggi inviati dall'utente
	static String get_messaggiinviati="SELECT * FROM messaggio WHERE id_mittente=? ORDER BY data DESC";
	
	//Query che dati due utenti, ritorna tutti i messaggi che questi utenti si sono mandati
	static String get_discussione="SELECT * FROM messaggio WHERE (id_mittente=? AND id_destinatario=?) OR (id_mittente=? AND id_destinatario=?)";
	
	//Query che ritorna il mittente del messaggio
	static String get_mittente="SELECT * FROM messaggio as ms,utenti as ut WHERE ms.id_messaggio=? AND ms.id_mittente=ut.id";
	
	//Query che ritorna un determinato messaggio dato l'id
	static String get_messaggio="SELECT * FROM messaggio WHERE id_messaggio=?";
	
	//Metodo che invia il messaggio all'utente selezionato
	public static void Invia_Messaggio(int id_mittente, int id_ricevente, String messaggio, String data) throws SQLException{
		Connection conn= null;
		try{
			conn= Connessione.getConnection();
			java.sql.PreparedStatement ps=conn.prepareStatement(invia_messaggio);
			ps.setInt(1, id_mittente);
			ps.setInt(2, id_ricevente);
			ps.setString(3, messaggio);
			ps.setString(4, data);
	        ps.executeUpdate();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//Metodo che controlla se il messaggio � stato visualizzato oppure no (true=visualizzato, false=non visualizzato)
	public static boolean Check_Letto(int id_messaggio) throws SQLException{
		Connection conn= null;
		try{
			conn= Connessione.getConnection();
			java.sql.PreparedStatement ps=conn.prepareStatement(check_letto);
			ps.setInt(1, id_messaggio);
	        ResultSet rs=ps.executeQuery();
	        if(rs.next()){
	        	return true;
	        }
	        return false;
		}
		catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
	
	//Metodo che fa considerare un messaggio gi� letto
	public static void Leggi_Messaggio(int id_messaggio) throws SQLException{
		Connection conn= null;
		try{
			conn= Connessione.getConnection();
			java.sql.PreparedStatement ps=conn.prepareStatement(leggi_messaggio);
			ps.setInt(1, id_messaggio);
	        ps.executeUpdate();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	//Metodo che controlla se ci sono messaggio che l'utente non ha mai letto(true=qualche non letto, false=tutti letti)
	public static boolean Check_EsistenzaNonLetti(int id_destinatario) throws SQLException{
		Connection conn= null;
		try{
			conn= Connessione.getConnection();
			java.sql.PreparedStatement ps=conn.prepareStatement(messaggi_non_letti);
			ps.setInt(1, id_destinatario);
	        ResultSet rs=ps.executeQuery();
	        if(rs.next()){
	        	return true;
	        }
	        return false;
		}
		catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
	
	//Metodo che Considera Letti tutti i messaggi ricevuti dall'utente.
	public static void Leggi_Tutto(int id_destinatario) throws SQLException{
		Connection conn= null;
		try{
			conn= Connessione.getConnection();
			java.sql.PreparedStatement ps=conn.prepareStatement(leggi_tutti_messaggi);
			ps.setInt(1, id_destinatario);
	        ps.executeUpdate();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//Metodo che ritorna tutti i messaggi che l'utente ha ricevuto
	public static ResultSet Get_MessaggiRicevuti(int id_destinatario) throws SQLException{
		Connection conn= null;
		try{
			conn= Connessione.getConnection();
			java.sql.PreparedStatement ps=conn.prepareStatement(get_messaggiricevuti);
			ps.setInt(1, id_destinatario);
			ResultSet rs=ps.executeQuery();
	        return rs;
		}
		catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	//Metodo che ritorna tutti i messaggi inviati dall'utente
	public static ResultSet Get_MessaggiInviati(int id_mittente) throws SQLException{
		Connection conn= null;
		try{
			conn= Connessione.getConnection();
			java.sql.PreparedStatement ps=conn.prepareStatement(get_messaggiinviati);
			ps.setInt(1, id_mittente);
			ResultSet rs=ps.executeQuery();
	        return rs;
		}
		catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	//Metodo che ritorna tutti i messaggi che si sono scambiati due utenti
	public static ResultSet Get_Discussione(int id_utente1,int id_utente2) throws SQLException{
		Connection conn= null;
		try{
			conn= Connessione.getConnection();
			java.sql.PreparedStatement ps=conn.prepareStatement(get_discussione);
			ps.setInt(1, id_utente1);
			ps.setInt(2, id_utente2);
			ps.setInt(3, id_utente2);
			ps.setInt(4, id_utente1);
			ResultSet rs=ps.executeQuery();
	        return rs;
		}
		catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	//Metodo che ritorna il mittente di un determinato messaggio
	public static ResultSet Get_Mittente(int id_messaggio) throws SQLException{
		Connection conn= null;
		try{
			conn= Connessione.getConnection();
			java.sql.PreparedStatement ps=conn.prepareStatement(get_mittente);
			ps.setInt(1, id_messaggio);
			ResultSet rs=ps.executeQuery();
	        return rs;
		}
		catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	//Metodo che ritorna un messsaggio dato l'id dello stesso
	public static ResultSet Get_Messaggio(int id_messaggio) throws SQLException{
		Connection conn= null;
		try{
			conn= Connessione.getConnection();
			java.sql.PreparedStatement ps=conn.prepareStatement(get_messaggio);
			ps.setInt(1, id_messaggio);
			ResultSet rs=ps.executeQuery();
	        return rs;
		}
		catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
}
