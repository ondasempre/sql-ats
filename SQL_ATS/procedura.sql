-- Dichiaro delle variabili e creo un cursore in maniera esplicita
declare 
c nominativi.cognome%TYPE;
n nominativi.nome%TYPE;
cursor nominativi_cur is 
select * from nominativi
for update;
BEGIN

	open nominativi_cur;
	loop 
		fetch nominativi_cur into n,c;
		exit when nominativi%notfound;
		update nominativi set nome = c, cognome = n
			where current of nominativi_cur;

	end loop;
	close nominativi_cur;
-- I commit fatti in una transazione andranno a committare anche i dati 
-- dati della procedura.
commit;