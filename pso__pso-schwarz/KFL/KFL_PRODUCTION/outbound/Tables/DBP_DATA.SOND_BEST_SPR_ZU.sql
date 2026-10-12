CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sond_best_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
sond_best_id STRING(1) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
sond_best_bez STRING(20) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);