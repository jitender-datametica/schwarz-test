--[OK] statement is translated correctly (syntax and type checks are fine)

DROP TABLE IF EXISTS DBP_ETL.artbew_konto_work_2 ;

CREATE TABLE DBP_ETL.artbew_konto_work_2  (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      konto_id INTEGER NOT NULL,
      bewart_id SMALLINT NOT NULL,
      nb_id SMALLINT NOT NULL,
      arthiertyp_id BYTEINT NOT NULL,
      umsatz_brutto DECIMAL(18,2),
      umsatz_netto DECIMAL(18,2),
      umsatz_wrg CHAR(3) COLLATE 'en-ci',
      umsatz_brutto_konz DECIMAL(18,2),
      umsatz_netto_konz DECIMAL(18,2),
      kjmo INTEGER)
;

