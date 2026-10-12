CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.art_sm_vw_zu_per_2 (
art_id INTEGER NOT NULL,
vw_id INTEGER NOT NULL,
sm_id STRING(4) COLLATE 'und:ci',
ksm_id STRING(4) COLLATE 'und:ci',
mandant_id INTEGER NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);