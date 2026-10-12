CREATE OR REPLACE TABLE kfl_production_dbp_ods_archiv.ods_bon_storno_2 (
bon_id STRING(100) NOT NULL,
bon_dat DATE NOT NULL,
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
bon_nr INTEGER NOT NULL,
kasse_nr INTEGER NOT NULL,
datei_name STRING(1020),
td_insert TIMESTAMP,
td_update TIMESTAMP
);