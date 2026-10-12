CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.in_fi_beleg_det_agg_payback_1 (
mandant_id BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0),
nb_id BIGNUMERIC(38,0),
dat_buch DATE,
art_id BIGNUMERIC(38,0),
wrg_id STRING(3) COLLATE 'und:ci',
betrag_fi_beleg_sum NUMERIC(18,4),
verarbeitet_fg BIGNUMERIC(38,0) DEFAULT 0,
td_update TIMESTAMP,
td_insert TIMESTAMP
);