--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.check_umsatz_s122_1;


CREATE TABLE IF NOT EXISTS dbp_etl.check_umsatz_s122_1 (
    quellsystem STRING(2),
    dat_bon STRING(8),
    kasse_schl STRING(4),
    wup_id INTEGER,
    kasse_krs_id STRING(5),
    kassierer_id INTEGER,
    kasse_nr INTEGER,
    journal_code STRING(4),
    vtweg_id STRING(2),
    vkorg_id STRING(4),
    bezirk_id STRING(6),
    wrg_id STRING(5),
    anz_bon_sap INTEGER,
    anz_bonpos_sap INTEGER,
    anz_abbruch_sap INTEGER,
    anz_bonstorno_sap INTEGER,
    anz_sofortstorno_sap INTEGER,
    anz_zeilenstorno_sap INTEGER,
    umsatz_netto_sap NUMERIC(29, 2) DEFAULT 0.00,
    umsatz_brutto_sap NUMERIC(29, 2) DEFAULT 0.00,
    wert_abbruch_sap NUMERIC(29, 2) DEFAULT 0.00,
    wert_bonstorno_sap NUMERIC(29, 2) DEFAULT 0.00,
    wert_sofortstorno_sap NUMERIC(29, 2) DEFAULT 0.00,
    umsatz_brutto_kassennr_sap NUMERIC(29, 2) DEFAULT 0.00,
    wert_zeilenstorno_sap NUMERIC(29, 2) DEFAULT 0.00,
    td_insert TIMESTAMP,
    td_update TIMESTAMP
);
