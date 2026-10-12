CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.lead_wup_region_2 (
region_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
land_id STRING(2) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);