--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.artbew_konto_work_2;


CREATE TABLE IF NOT EXISTS dbp_etl.artbew_konto_work_2 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    konto_id INTEGER NOT NULL,
    bewart_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    arthiertyp_id INTEGER NOT NULL,
    umsatz_brutto NUMERIC(29, 2),
    umsatz_netto NUMERIC(29, 2),
    umsatz_wrg STRING(3) COLLATE 'und:ci',
    umsatz_brutto_konz NUMERIC(29, 2),
    umsatz_netto_konz NUMERIC(29, 2),
    kjmo INTEGER
);
