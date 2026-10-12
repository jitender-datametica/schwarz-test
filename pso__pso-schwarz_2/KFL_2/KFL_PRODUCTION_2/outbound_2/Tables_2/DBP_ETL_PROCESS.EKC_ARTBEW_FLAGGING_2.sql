CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.ekc_artbew_flagging_2 (
mandant_id BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0),
art_id BIGNUMERIC(38,0),
dat DATE,
bewart_id BIGNUMERIC(38,0),
menge NUMERIC(18,3),
menge_sum NUMERIC(18,3),
anteil FLOAT64,
td_insert TIMESTAMP,
td_update TIMESTAMP,
bewart_det_id BIGNUMERIC(38,0) DEFAULT 9999 NOT NULL
);