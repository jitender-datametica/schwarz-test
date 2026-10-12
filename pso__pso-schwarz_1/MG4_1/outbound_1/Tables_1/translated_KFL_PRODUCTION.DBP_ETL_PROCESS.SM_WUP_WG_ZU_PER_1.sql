CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.sm_wup_wg_zu_per_1 (
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
wg_id INTEGER NOT NULL,
arthiertyp_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE,
sm_id INTEGER,
ksm_id STRING(4) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);