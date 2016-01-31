CREATE TABLE IF NOT EXISTS domanda(
	id_domanda int(11) NOT NULL AUTO_INCREMENT,
	id_domandante int(11) NOT NULL,
	titolo varchar(255) NOT NULL,
	descrizione varchar(512) NOT NULL,
	data date NOT NULL,
	PRIMARY KEY(id_domanda),
	FOREIGN KEY (id_domandante) REFERENCES utenti(id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;