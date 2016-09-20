-- Esercizio 4
-- Avendo due tabelle A e B interrogate da una vista (3 campi per tabella), creare una procedura di aggiornamento
-- per tutti i campi di tali tabelle che si appoggi ad un trigger che mantenga l’integrità referenziale.

-- Se una tabella non riesce ad essere aggiornata l'eccezione provocata non deve compromettere l'aggiornamento dell'altra.


-- Creazione delle tabelle da gestire con la procedura --

------------------- Inizio ---------------------------------

create table Cliente (
  id int NOT NULL,
  nome varchar2(30) NOT NULL,
  cognome varchar2(30) NOT NULL,
  idEvento int,
  constraint id_cli primary key (id),
  constraint id_even foreign key (idEvento) references Evento(id)
);

create table Evento (
  id int NOT NULL,
  nomeEvento varchar2(50) NOT NULL,
  constraint id_evento primary key (id)
);

------------------- Fine -----------------------------------



-- Creazione del trigger --

CREATE OR REPLACE TRIGGER checker
  instead of insert on miaVista
  DECLARE
    id_cliente Cliente.id%TYPE;
    id_evento Evento%ROWTYPE;
BEGIN
 BEGIN
  SELECT c1.id INTO id_cliente
  FROM Cliente c1
  WHERE nome = :new.nome and cognome = :new.cognome
  -- SOLLEVO ECCEZIONE SE NON TROVO I DATI
  EXCEPTION WHEN no_data_found THEN
  raise_application_error(ORA-01403,sqlerror);

  INSERT INTO Cliente values( :new.id, :new.nome, :new.cognome );
    returning id INTO id_cliente;
 END;

 select * into id_evento from Evento where id=:new.id;

 IF id_evento.idEvento != NULL THEN
  UPDATE Evento SET idEvento = id_cliente where id = :new.id;
 END IF;

END;
/
