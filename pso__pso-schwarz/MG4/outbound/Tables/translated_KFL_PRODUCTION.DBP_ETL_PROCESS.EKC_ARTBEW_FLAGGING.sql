CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.ekc_artbew_flagging (
mandant_id INTEGER,
wup_id INTEGER,
art_id INTEGER,
dat DATE,
bewart_id INTEGER,
menge NUMERIC(18,3),
menge_sum NUMERIC(18,3),
anteil FLOAT64,
td_insert TIMESTAMP,
td_update TIMESTAMP,
bewart_det_id INTEGER DEFAULT 9999 NOT NULL
);