CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.in_fi_beleg_det_agg_payback (
mandant_id INTEGER,
wup_id INTEGER,
nb_id INTEGER,
dat_buch DATE,
art_id INTEGER,
wrg_id STRING(3) COLLATE 'und:ci',
betrag_fi_beleg_sum NUMERIC(18,4),
verarbeitet_fg INTEGER DEFAULT 0,
td_update TIMESTAMP,
td_insert TIMESTAMP
);