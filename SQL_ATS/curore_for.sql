-- Gestione del cursore

-- if nome_cur%notfound then

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
-- PER LA MODIFICA DOBBIAMO USARE WHILE O LOOP COME VISTO PRECEDENTEMENTE.



-- LOOP, WHILE, FOR