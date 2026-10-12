CREATE OR REPLACE TABLE dbp_etl.umsnetto (
    buchungskreis STRING(4),
    marktnummer STRING(4),
    fi_konto STRING(10),
    kontobez STRING(50),
    netto_umsatz STRING(12),
    brutto_umsatz STRING(12),
    steuersatz STRING(2),
    gjmo STRING(6),
    td_insert TIMESTAMP,
    td_update TIMESTAMP
);


CREATE OR REPLACE TABLE dbp_etl.artbew_konto_work (
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


CREATE OR REPLACE TABLE dbp_etl.artbew_abt_sum_work (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    abt_id INTEGER NOT NULL,
    bewart_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    arthiertyp_id INTEGER NOT NULL,
    umsatz_brutto NUMERIC(29, 2),
    umsatz_netto NUMERIC(29, 2),
    umsatz_wrg STRING(3) COLLATE 'und:ci',
    umsatz_brutto_konz NUMERIC(29, 2),
    umsatz_netto_konz NUMERIC(29, 2),
    kjmo INTEGER NOT NULL
);
