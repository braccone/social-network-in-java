CREATE TABLE IF NOT EXISTS utenti (
	id int(11) NOT NULL AUTO_INCREMENT,
	username varchar(255) NOT NULL,
	email varchar(255) NOT NULL,
	password varchar(128) NOT NULL,
	data_registrazione date NOT NULL,
	attivato enum('0','1') NOT NULL,
	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;