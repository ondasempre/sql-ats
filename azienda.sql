-- Progetto Azienda Accenture :: softwarehouse

create table Dipendente (
	cf varchar(16) NOT NULL,
	nome varchar2(50),
	cognome varchar2(50),
	constraint d_id primary key(cf)
);

create table Pagamento (
	id int NOT NULL,
	data date,
	modalita varchar2(50),
	importo number(10,2),
	constraint pag_id primary key(id)
);

create table AziendaCommittente (
	id int NOT NULL,
	nome varchar2(50),
	constraint ac_id primary key(id)
);

create table Fornitore (
	id int NOT NULL,
	constraint f_id primary key(id)
);

create table Materiali (
	id int NOT NULL,
	dsc varchar2(50) NOT NULL,
	quantita int NOT NULL,
	costo number(10,2) NOT NULL,
	constraint p_id primary key(id)
);

create table Manager (
	-- cf varchar(16) NOT NULL,
	-- vincolo 1,1 su manager
	cf varchar(16) NOT NULL, 
	nome varchar2(50) NOT NULL,
	cognome varchar2(50) NOT NULL,
	constraint m_id primary key(cf),
);

create table Progetti (
	id int NOT NULL,
	id_az int NOT NULL,
	inizio date,
	fine date,
	cf varchar(16) NOT NULL, 
	check(inizio < fine),
	constraint p_id primary key(id),
	-- vincolo (1,1)
	constraint pm_id foreign key (cf) references Manager(cf),
	constraint ac_id foreign key (id_az) references AziendaCommittente(id)

);

-- relationship

create table lavora (
	progetto int NOT NULL,
	dipendente varchar(16) NOT NULL, 
	unique(progetto, dipendente),
	constraint lavora_id foreign key (progetto) references Progetti(id),
	constraint dip_id foreign key (dipendente) references Dipendente(cf)
);

create table fornisce (
	fornitore int NOT NULL,
	materiale int NOT NULL, 
	unique(fornitore, materiale),
	constraint forn_id foreign key (fornitore) references Fornitore(id),
	constraint mate_id foreign key (materiale) references Materiali(id)
);

create table uso (
	materiale int NOT NULL,
	progetto int NOT NULL, 
	unique(materiale, materiale),
	constraint mat foreign key (materiale) references Materiali(id),
	constraint prog foreign key (progetto) references Progetti(id)
);













