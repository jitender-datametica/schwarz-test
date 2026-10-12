CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kalk_schema_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kalk_schema_id STRING(7) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
kalk_schema_bez STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);