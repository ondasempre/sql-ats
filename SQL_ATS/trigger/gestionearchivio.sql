create or replace procedure gestionearchivio(p_isbn char, p_quantita int)
  v_quantita magazzino.quantita%type;
  cursor archivio_cur is
  select quantita from magazzino
  where isbn in (
    select isbn
    from Libri
    where prezzo > 10
    AND categoria = 'Romanzo'
  ) from UPDATE;

  BEGIN

    open archivio_cur;
    loop
    fetch archivio_cur into v_quantita;
    exit when archivio_cur%notfound;
    dbms_output.put_line(v_quantita);
    v_quantita := v_quantita + p_quantita;
    update magazzino set quantita = v_quantita;
    current of archivio_cur;
    dbms_output.put_line(v_quantita);
    end loop;
    close archivio_cur;

end;
/
