CREATE TABLE IF NOT EXISTS amico(
	id_richiesta int(11) NOT NULL AUTO_INCREMENT,
	id_richiedente int(11) NOT NULL,
	id_ricevente int(11) NOT NULL,
	accettato boolean NOT NULL,
	PRIMARY KEY(id_richiesta),
	FOREIGN KEY (id_richiedente) REFERENCES utenti(id),
	FOREIGN KEY (id_ricevente) REFERENCES utenti(id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;