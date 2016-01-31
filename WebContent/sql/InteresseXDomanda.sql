CREATE TABLE IF NOT EXISTS interesse_domanda(
	id_interesse int(11) NOT NULL,
	id_domanda int(11) NOT NULL,
	PRIMARY KEY(id_interesse,id_domanda),
	FOREIGN KEY (id_interesse) REFERENCES interesse(id_interesse),
	FOREIGN KEY (id_domanda) REFERENCES domanda(id_domanda)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;