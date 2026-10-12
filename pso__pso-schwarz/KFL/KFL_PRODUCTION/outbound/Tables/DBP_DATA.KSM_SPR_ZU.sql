CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ksm_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
ksm_id STRING(4) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
ksm_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);