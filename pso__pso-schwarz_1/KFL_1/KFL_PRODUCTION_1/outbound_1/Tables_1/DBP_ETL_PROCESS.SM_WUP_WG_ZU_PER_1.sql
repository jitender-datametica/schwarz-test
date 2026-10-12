CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.sm_wup_wg_zu_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
wg_id BIGNUMERIC(38,0) NOT NULL,
arthiertyp_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE,
sm_id BIGNUMERIC(38,0),
ksm_id STRING(4) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);