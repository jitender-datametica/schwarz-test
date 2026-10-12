CREATE OR REPLACE TABLE kfl_production_dbp_ods_archiv.ods_bon_leergut_2 (
bon_id STRING(100) NOT NULL,
bon_zeile INTEGER NOT NULL,
ean_kasse NUMERIC(29,0),
umsatz_brutto NUMERIC(29,4) DEFAULT 0 NOT NULL,
mandant_id INTEGER,
wup_id INTEGER,
start_bon_zeile DATETIME,
bon_nr_extern INTEGER,
bon_dat DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);