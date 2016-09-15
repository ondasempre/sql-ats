-- TRANSAZIONE AUTONOME
create table Logdip (
	username varchar2(50),
	datamodifica timestamp
);

-- Procedura gestisci log
create or replace procedure gestiscilog (p_username varchar2, p_data timestamp) as
pragma autonomus_trasaction
BEGIN
	insert into logdip values(p_username, p_data);
		commit;

end;
/


create or replace procedure genitore (p_nome varchar2,  p_cognome varchar2) as 

	BEGIN 
		-- user recupera automaticamente il nome dell'user che sta facendo insert 
		
		insert into nominativi values (p_nome,p_cognome);
		gestiscilog(user, systimestamp);
		rollback;

end;
/

-- Se faccio rollback perdo i dati di Nominativi.
-- Attenzione ad usare transazioni autonome....