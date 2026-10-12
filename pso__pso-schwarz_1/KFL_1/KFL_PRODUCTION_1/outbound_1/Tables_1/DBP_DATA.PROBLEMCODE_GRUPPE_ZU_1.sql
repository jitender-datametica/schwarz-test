CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.problemcode_gruppe_zu_1 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
problemgruppe_id BIGNUMERIC(38,0) NOT NULL,
problemcode_id STRING(7) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);