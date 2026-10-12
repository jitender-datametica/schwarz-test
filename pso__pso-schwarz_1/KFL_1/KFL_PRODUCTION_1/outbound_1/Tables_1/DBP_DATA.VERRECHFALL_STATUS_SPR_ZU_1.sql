CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.verrechfall_status_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
verrechfall_status_id STRING(10) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
verrechfall_status_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);