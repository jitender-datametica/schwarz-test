CREATE OR REPLACE TABLE dbp_etl.marktbestand_erp_zbi_mard (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    bestand_id INTEGER NOT NULL,
    bezugsweg_id INTEGER DEFAULT -1 NOT NULL,
    relevant_fg INTEGER DEFAULT 1 NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3) NOT NULL,
    menge_lgbest_erp_qual_bme NUMERIC(29, 3) NOT NULL,
    fortschreibung_fg INTEGER DEFAULT -1 NOT NULL,
    td_insert TIMESTAMP,
    td_update TIMESTAMP,
    uzeit INTEGER,
    laeda DATE,
    abi_rec_nr INTEGER,
    menge_lgbest_erp_gesp_bme NUMERIC(29, 3) NOT NULL
);
