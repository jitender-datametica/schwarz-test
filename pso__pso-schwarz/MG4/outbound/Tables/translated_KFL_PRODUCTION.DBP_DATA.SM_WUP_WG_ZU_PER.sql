CREATE OR REPLACE TABLE kfl_production_dbp_data.sm_wup_wg_zu_per (
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
wg_id INTEGER NOT NULL,
arthiertyp_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
dat_von DATE NOT NULL,
spr_id INTEGER,
dat_bis DATE,
sm_id INTEGER,
ksm_id STRING(4) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);