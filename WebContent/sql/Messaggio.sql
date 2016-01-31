CREATE TABLE IF NOT EXISTS messaggio(
	id_messaggio int(11) NOT NULL AUTO_INCREMENT,
	id_mittente int(11) NOT NULL,
	id_destinatario int(11) NOT NULL,
	titolo varchar(255) NOT NULL,
	testo varchar(512) NOT NULL,
	data date NOT NULL,
	letto boolean NOT NULL,
	PRIMARY KEY(id_messaggio),
	FOREIGN KEY (id_mittente) REFERENCES utenti(id),
	FOREIGN KEY (id_destinatario) REFERENCES utenti(id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;