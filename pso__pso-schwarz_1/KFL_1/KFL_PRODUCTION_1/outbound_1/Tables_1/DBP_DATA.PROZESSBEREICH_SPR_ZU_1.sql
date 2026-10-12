CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.prozessbereich_spr_zu_1 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
prozessbereich_id STRING(10) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
prozessbereich_bez STRING(60) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);