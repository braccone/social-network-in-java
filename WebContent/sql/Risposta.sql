CREATE TABLE IF NOT EXISTS risposta(
	id_risposta int(11) NOT NULL AUTO_INCREMENT,
	id_domanda int(11) NOT NULL,
	id_rispondente int(11) NOT NULL,
	testo varchar(512) NOT NULL,
	data date NOT NULL,
	letto boolean NOT NULL,
	PRIMARY KEY(id_risposta),
	FOREIGN KEY (id_domanda) REFERENCES domanda(id_domanda),
	FOREIGN KEY (id_rispondente) REFERENCES utenti(id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;