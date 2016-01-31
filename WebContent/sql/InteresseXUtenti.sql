CREATE TABLE IF NOT EXISTS interesse_utenti(
	id_persona int(11) NOT NULL,
	id_interesse int(11) NOT NULL,
	PRIMARY KEY(id_persona,id_interesse),
	FOREIGN KEY (id_persona) REFERENCES utenti(id),
	FOREIGN KEY (id_interesse) REFERENCES interesse(id_interesse)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;