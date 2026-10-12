CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.shr_datenfreigabe_1 (
mandant_id INTEGER NOT NULL,
kjmo INTEGER NOT NULL,
dat DATE NOT NULL,
nat_int_fg INTEGER DEFAULT 0 NOT NULL,
user_id STRING(30) COLLATE 'und:ci' NOT NULL,
freigabe_uhrzeit INTEGER NOT NULL,
shr_freigabe_fg INTEGER NOT NULL,
dat_freigabe_kennzahlen DATE,
td_insert TIMESTAMP,
td_update TIMESTAMP
);