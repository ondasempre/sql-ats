-- Esercizio 1

--Scrivere una procedura PL/SQL che in base ad un valore intero passato in ingresso, mostri a video
--i risultati, prendendo i valori di tutti i campi delle due tabelle utilizzando una inner join e
--una left join.
--Implementare il tutto attraverso l'utilizzo di cursori, a partire dalle tabelle mostrate di seguito:

-- Creazione delle tabelle con vincoli

------------------- Inizio ---------------------------------

create table Fornitori (
  id int NOT NULL,
  denominazione varchar2(30),
  constraint id_f primary key (id)
);

create table Aziende (
  id int NOT NULL,
  idfornitore int NOT NULL,
  constraint id_a primary key (id),
  constraint id_azien foreign key (idfornitore) references Fornitori(id)
);

------------------- Fine -----------------------------------

-- Creazione della procedura che prende un parametro intero per selezionare il tipo di Join --
DECLARE
   a number;
PROCEDURE joinProc(x IN int) IS
BEGIN

    BEGIN
      IF ( x = 1 ) THEN
        SELECT * FROM Fornitori JOIN Aziende ON Fornitori.id = Aziende.idfornitore;
      END IF;
    END;

    BEGIN
      IF ( x = 2 ) THEN
        SELECT * FROM Fornitori LEFT OUTER JOIN Aziende ON Fornitori.id = Aziende.idfornitore;
      END IF;
    END;

    EXCEPTION
         WHEN x > 2 THEN
          dbms_output.put_line('Error!');
END;
/

-- Fine procedura --
