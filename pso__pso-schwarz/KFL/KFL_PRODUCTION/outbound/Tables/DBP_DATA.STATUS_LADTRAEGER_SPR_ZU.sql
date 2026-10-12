CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.status_ladtraeger_spr_zu (
status_ladtraeger STRING(1) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
status_ladtraeger_bez STRING(50) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);