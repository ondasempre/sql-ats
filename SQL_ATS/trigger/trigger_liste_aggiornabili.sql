-- Trigger :: liste aggiornabili 
-- Puoi utilizzare una maschera realizzata con una view per inserire
-- i dati all'interno della tabella.


-- Come creare un trigger .. che mantiene l'integrità dei dati.

CREATE VIEW Selezione AS 
SELECT isbn, titolo, nome
FROM Libri, Autori
WHERE 
		autori.id = libri.autore1
	or
		autori.id = libri.autore2
	or
		autori.id = libri.autore3
	or
		autori.id = libri.autore4;

-- Trigger per la modifica di un parametro all'interno della tabella Autori e Libri.
CREATE OR REPLACE TRIGGER Controllo_itegrita
INSTEAD OF INSERT ON Selezione
DECLARE
	v_libri libri%rowtype;
	v_aid autori%type;

BEGIN 
		BEGIN
				SELECT id into v_aid 
				FROM Autori 
				WHERE nome = :new.nome
				AND cognome = :new.cognome
		EXCEPTION 
				WHEN no_data_found THEN
				INSERT into Autori values(:new.id , :new.nome , :new.cognome);
				RETURNING :new.id into v_aid;
		END;

		SELECT * into v_libri 
		FROM Libri
		WHERE isbn = :new.isbn;

		if v_libri.autore2 is NULL THEN
			UPDATE libri set autore2 = v_aid; 
			WHERE isbn = :new.isbn;

				elsif v_libri.autore3 is NULL THEN
			UPDATE libri set autore2 = v_aid; 
			WHERE isbn = :new.isbn;

					elsif v_libri.autore4 is NULL THEN
			UPDATE libri set autore2 = v_aid; 
			WHERE isbn = :new.isbn;

			end if;

END;
/ 