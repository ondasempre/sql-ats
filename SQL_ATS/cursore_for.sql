-- Gestione del cursore in PL/SQL

-- ROWTYPE è utile quando bisogna scrivere dei dati utilizzando un cursore.
set serveroutput on 
declare
	-- v_dipendente Dipendente%rowtype; 
	cursor dip_cur is
	select * from Dipendente;

BEGIN 
	-- PL/SQl non è fortemente tipizzato
	for x in dip_cur
		
		dbms_output.put_line(v_dipendente.nome,v_dipendente.stipendio)

	end loop;
	
end;
/


-- CON IL FOR NON POSSIAMO MODIFICARE I DATI SUI QUALI STIAMO CICLANDO.
-- PER LA MODIFICA DOBBIAMO USARE WHILE O LOOP COME VISTO PRECEDENTEMENTE (vedi altre procedure PL/SQL).



-- LOOP, WHILE, FOR
