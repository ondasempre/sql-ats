CREATE TABLE Spettatore( -- spettatori
	idspettacolo CHAR(16)  PRIMARY KEY,
	nominativo CHAR(64) NOT NULL,
	tel CHAR(16),
	quartiere CHAR(16),
	citta CHAR(64)
);

CREATE TABLE Concerto( -- concerti
	idconcerto CHAR(16)  PRIMARY KEY,
	titolo CHAR(256) NOT NULL,
	artista CHAR(256),
	data CHAR(8) NOT NULL
);
CREATE TABLE Prenotazione( -- prenotazioni
 idspettatore CHAR(16) NOT NULL,
 idconcerto CHAR(16) NOT NULL,
 prezzo numeric(8,2),
  PRIMARY KEY (idspettatore,idconcerto),
  FOREIGN KEY (idspettatore) REFERENCES spettatore,
  FOREIGN KEY (idconcerto) REFERENCES concerto
);



INSERT INTO Spettatore VALUES(	'Spettatore1',	'N1',	'TE1',	'Q1',	'C1'	);
INSERT INTO Spettatore VALUES(	'Spettatore2',	'N2',	'TE2',	'Q1',	'C1'	);
INSERT INTO Spettatore VALUES(	'Spettatore3',	'N3',	'TE3',	'Q2',	'C1'	);
INSERT INTO Spettatore VALUES(	'Spettatore4',	'N4',	'TE4',	'Q2',	'C1'	);
INSERT INTO Spettatore VALUES(	'Spettatore5',	'N5',	'TE5',	'Q3',	'C1'	);
INSERT INTO Spettatore VALUES(	'Spettatore6',	'N6',	'TE6',	'Q3',	'C1'	);
INSERT INTO Spettatore VALUES(	'Spettatore7',	'N7',	'TE7',	'Q3',	'C1'	);
INSERT INTO Spettatore VALUES(	'Spettatore8',	'N8',	'TE8',	'Q4',	'C1'	);

INSERT INTO Concerto VALUES(	'S1',	'TT1',	'A1',	'20020101'	);
INSERT INTO Concerto VALUES(	'S2',	'TT2',	'A1',	'20020601'	);
INSERT INTO Concerto VALUES(	'S3',	'TT3',	'A2',	'20021201'	);
INSERT INTO Concerto VALUES(	'S4',	'TT3',	'A2',	'20030601'	);
INSERT INTO Concerto VALUES(	'S5',	'TT4',	'A3',	'20010401'	);

INSERT INTO Prenotazione VALUES(	'Spettatore1',	'S1',	25	);
INSERT INTO Prenotazione VALUES(	'Spettatore2',	'S2',	30	);
INSERT INTO Prenotazione VALUES(	'Spettatore2',	'S3',	35	);
INSERT INTO Prenotazione VALUES(	'Spettatore3',	'S3',	35	);
INSERT INTO Prenotazione VALUES(	'Spettatore2',	'S4',	25	);
INSERT INTO Prenotazione VALUES(	'Spettatore4',	'S4',	25	);


	SELECT c.titolo, s.citta, COUNT(p.idspettacolo) AS numeroPren, SUM(p.prezzo) AS importo
	FROM Concerto c, Prenotazione p, Spettatore s
	WHERE c.idconcerto = p.idconcerto
	AND s.idspettatore = p.idspettatore
	GROUP BY (c.titolo,s.citta)
	ORDER BY importo DESC;
