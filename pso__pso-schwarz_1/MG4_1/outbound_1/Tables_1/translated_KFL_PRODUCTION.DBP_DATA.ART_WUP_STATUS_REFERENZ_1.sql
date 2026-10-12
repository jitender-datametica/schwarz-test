CREATE OR REPLACE TABLE kfl_production_dbp_data.art_wup_status_referenz_1 (
mandant_id INTEGER NOT NULL,
art_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
art_id_ref INTEGER DEFAULT - 1 NOT NULL,
wup_id_ref INTEGER DEFAULT - 1 NOT NULL,
nb_id_ref INTEGER DEFAULT 0 NOT NULL,
dat_bis_ref DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL,
faktor_ref NUMERIC(9,2) DEFAULT 1 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);