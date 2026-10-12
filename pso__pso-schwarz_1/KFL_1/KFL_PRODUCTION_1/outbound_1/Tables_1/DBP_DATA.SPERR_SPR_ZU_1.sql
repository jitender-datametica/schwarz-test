CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sperr_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
sperr_id STRING(1) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
sperr_bez STRING(50) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);