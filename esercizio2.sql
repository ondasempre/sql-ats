-- Esercizio 2
-- Avendo un’ipotetica tabella che registra vendite di prodotti creare:
-- 1. una funzione di calcolo che permetta di totalizzare le vendite effettuate;
-- 2. una procedura di stampa report che permetta la generazione di un report che elenchi gli ultimi 5 acquisti pi˘ onerosi;

----------------------------------------------------------------------

-- Creazione di una funzione che torna il numero di vendite effettuate per un certo prodotto
CREATE FUNCTION vendite_effettuate() RETURN number IS
  tot_vendite number := null;
BEGIN
  SELECT sum(vendite) INTO tot_vendite FROM Prodotti;
  RETURN tot_vendite;
END;


----------------------------------------------------------------------


-- Procedura per generare il Report sui prodotti venduti
CREATE OR REPLACE PROCEDURE Report
  CURSOR cursore IS
SELECT nome
FROM vendite v
GROUP BY nome
ORDER BY prezzo;

  v_nome v.nome%type; -- selezione per tipo dell'oggetto
  DECLARE i int;

    BEGIN
      i := 0;
      OPEN cursore;
      LOOP
      FETCH cursore INTO v_nome;
        exit WHEN cursore%notfound
        IF (i < 5) THEN
         DBMS_OUTPUT.PUT_LINE ( 'Prodotto :: ' || v.name );
        END IF;
      END LOOP;
 CLOSE cursore;

END;
/

----------------------------------------------------------------------
