CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ssm_bereich_spr_zu (
wup_bereich_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
wup_bereich_bez STRING(20) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);