-- Esercizio 3

/*
Tab da creare:
RISTORANTE(NomeRist, Localit‡, Indirizzo, Telefono, #Posti)
RISTORANTE_OFFRE_MENU(NomeRist, Localit‡, IdMenu)
MENU(IdMenu, NomePortata)
PREZZO(IdMenu, Costo)
PORTATA(NomePortata, Prezzo, Tipo, Specialit‡)
INGREDIENTE(NomeIngrediente, Tipo)
INGREDIENTI_IN_PORTATA(NomePortata, NomeIngrediente, Quantit‡)
BANCHETTO(Codice, Occasione, Data, #Partecipanti, CodFiscCliente,
NomeRistorante, Localit‡, IdMenu)
INVITATO(CodiceBanchetto, CodFiscInvitato)
PERSONA(CodiceFiscale, Nome, Cognome, DataNascita, Indirizzo, #Telefono,
Professione)
*/

-- Creazione delle tabelle del database Azienda
create table Ristorante (
  nomeRist varchar2(30),
  localita varchar2(30),
  indirizzo varchar2(30),
  telefono numeric(10,0),
  posti numeric(3,0),
  constraint p_risto primary key (nomeRist, localita)
);

create table Menu (
  idmenu numeric(6,0) primary key,
  nome_portata varchar2(30),
  foreign key (nome_portata) references Portata(nome_portata)
);

create table Risto_offre_menu (
  nomeRist varchar2(30),
  localita varchar2(30),
  idmenu numeric(6,0) references menu(idmenu),
  constraint f_risto foreign key (nomeRist,localita)
  references ristorante(nomeRist,localita)
);

create table Prezzo (
  idmenu numeric(6,0),
  costo numeric(5,2),
  foreign key (idmenu) references Menu(idmenu)
);

create table Portata (
  nome_portata varchar2(30) primary key,
  prezzo numeric(5,2),
  tipo varchar2(30),
  specialita varchar2(30)
);

create table Ingredienti (
  nome_ingrediente varchar2(30) primary key,
  tipo varchar2(30)
);

create table Ingredienti_in_portata (
  nome_portata varchar2(30) references portata(nome_portata),
  nome_ingrediente varchar2(30) references ingredienti(nome_ingrediente),
  quantita numeric(4,0)
);

create table Banchetto (
  codice_b numeric(6,0) primary key,
  occasione varchar2(30),
  data_b date,
  partecipanti numeric(3,0),
  cf_cliente numeric(16,0) references persona(cf),
  nomeRist varchar2(30),
  localita varchar2(30),
  constraint f_ristoB foreign key (nomeRist,localita)
  references ristorante(nomeRist,localita),
  idmenu numeric(6,0) references menu(idmenu)
);

create table Invitato (
  codice_b numeric(6,0) references banchetto(codice_b),
  cf_invitato numeric(16,0) references persona(cf)
);

create table Persona (
  cf numeric(16,0) primary key,
  nome varchar2(30),
  cognome varchar2(30),
  data_nascita Date,
  indirizzo varchar2(30),
  telefono numeric(10,0),
  professione varchar2(30)
);


-- 1.  TROVARE DATA, NUMERO DEI PARTECIPANTI, NOME DEL RISTORANTE E LOCALITA'
-- PER I BANCHETTI ORGANIZZATI IN OCCASIONE DI BATTESIMI

SELECT b.data, b.partecipanti, r.nomerist, r.localita
FROM Ristorante r, Banchetto b
WHERE b.occasione = 'Battesimo'
AND b.NomeRistorante = r.NomeRistorante;

-- 2.  TROVARE LA LOCALITA' CON IL RISTORANTE
-- CON PIU' POSTI DISPONIBILI
SELECT r.localita
FROM Ristorante r
WHERE all>= ( SELECT max(r1.posti) FROM Ristorante r1 );


-- 3.  TROVARE IL NOME DI TUTTE LE PORTATE
-- CHE HANNO TRA GLI INGREDIENTI ALMENO 600 GR DI SALE
SELECT p.NomePortata
FROM Portata p, Ingredienti_in_Portata ip
WHERE p.NomePortata = ip.NomePortata
AND ip.quantita > 600
AND ip.NomeIngrediente = 'sale';

-- 4.  TROVARE IL NOME DI TUTTE LE PORTATE CHE HANNO TRA GLI INGREDIENTI
-- ALMENO 30 GR DI OLIO, 20 DI SALE E 50 DI FARINA
SELECT p.NomePortata
FROM Portata p, Ingredienti_in_Portata ip1,Ingredienti_in_Portata ip2, Ingredienti_in_Portata ip3
WHERE (p.NomePortata = ip1.NomePortata OR p.NomePortata = ip2.NomePortata OR p.NomePortata = ip3.NomePortata )
AND ( (ip1.quantita >= 20 AND ip1.NomeIngrediente = 'sale')
OR (ip2.quantita >= 30 AND ip2.NomeIngrediente = 'olio')
OR (ip3.quantita >= 50 AND ip3.NomeIngrediente = 'farina') );

-- 5.  TROVARE IL NOME DI TUTTI I RISTORANTI DI NAPOLI E CATANIA
-- CHE ABBIANO ALMENO 600 POSTI MA NON PIU' DI 1000
SELECT r.nomerist
FROM Ristorante r
WHERE r.posti >= 600 AND r.posti < 1000
AND (r.localita = 'Napoli' OR r.localita = 'Catania');

-- 6.  TROVARE IL NOME DI TUTTI I RISTORANTI DI MILANO IN CUI E'
-- STATO ORGANIZZATO UN BANCHETTO PER UN BATTESIMO CON MENO DI 300 INVITATI.
--  VISUALIZZARE I RISULTATI IN ORDINE DECRESCENTE SUL NUMERO DI
-- INVITATI.
SELECT r.nomerist
FROM Ristorante r, Banchetto b
WHERE r.localita = 'Milano'
AND b.occasione = 'Battesimo'
AND b.NomeRistorante = r.nomerist
AND b.partecipanti < 300
ORDER BY DESC b.partecipanti;

-- 7.  TROVARE IL PREZZO DEL PRIMO PIATTO CHE COSTA DI MENO
SELECT min(prezzo)
FROM portata
WHERE tipo = 'Primo';

-- 8.  TROVARE LE LOCALITA' IN CUI SI TROVANO
-- RISTORANTI ESCLUDENDO I DUPLICATI
SELECT DISTINCT r.localita
FROM Ristoranti r;

-- 9.  TROVARE IL NUMERO TOTALE DI INVITATI CHE HANNO PARTECIPATO AI BANCHETTI
-- ORGANIZZATI DALL'AGENZIA SUDDIVISI PER TIPO DI OCCASIONE
SELECT count(*)
FROM Invitati i, Banchetti b
WHERE i.codicebanchetto = b.codice
GROUP BY b.occasione;

-- 10. TROVARE NOME E COGNOME DELLE PERSONE CHE SI SONO RIVOLTE ALL'AGENZIA
-- PER ORGANIZZARE UN BANCHETTO IN OCCASIONE DI UN MATRIMONIO
SELECT p.nome, p.cognome
FROM Persona p, Banchetto b
WHERE b.occasione = 'Matrimonio'
AND b.CodFiscCliente = p.CodiceFiscale;

-- 11. TROVARE IL NOME DEI RISTORANTI E LA RISPETTIVA LOCALITA'
-- IN CUI SIA PRESENTE UN MENU CON SPAGHETTI AL PESTO
SELECT r.nomerist, r.localita
FROM Ristorante r, RISTORANTE_OFFRE_MENU rom, MENU m
WHERE rom.nomerist = r.nomerist
AND m.idmenu = rom.idmenu
AND m.nome_portata = 'Spaghetti al pesto';



-- 12. TROVARE LE PERSONE CHE HANNO LO STESSO COGNOME
-- DI UN PROFESSORE ORDINARIO
SELECT p1.CodiceFiscale, p1.nome, p1.cognome
FROM Persona p1, Persona p2
WHERE p2.professione = 'Professore Ordinario'
AND p1.cognome = p2.cognome;



-- 13. CREARE UNA VISTA CHE CONTENGA NOME E LOCALITA' DI TUTTI I RISTORANTI CARATTERISTICI
-- (OVVERO RISTORANTI CHE OFFRONO SPECIALITA')
CREATE VIEW my_view AS
SELECT r.nomerist, r.localita
FROM Ristorante r, RISTORANTE_OFFRE_MENU rom, Menu m, Portata p
where p.specialita != NULL
AND r.nomerist = rom.nomerist
AND rom.idmenu = m.idmenu
AND p.NomePortata = m.NomePortata;
