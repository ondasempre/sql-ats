-- Gestione del cursore

-- if nome_cur%notfound then

-- ROWTYPE è utile quando bisogna scrivere dei dati utilizzando un cursore.
set serveroutput on 
declare
	v_dipendente Dipendente%rowtype; 
	cursor dip_cur is
	select * from Dipendente;

BEGIN 
	open dip_cur;
		fetch dip_cur into v_dipendente;
		-- condizione while
		while dip_cur%found
		loop
		-- usiamo questa tecnica per stampare tutte le righe

		
		-- packege è una lista di funzioni che si possono recuperare dalla libreria
		-- DBMS_OUTPUT è come print() in Java
		dbms_output.put_line(v_dipendente.nome || v_dipendente.stipendio);
		fetch dip_cur into v_dipendente;			

	end loop;
	close dip_cur;

end;
/