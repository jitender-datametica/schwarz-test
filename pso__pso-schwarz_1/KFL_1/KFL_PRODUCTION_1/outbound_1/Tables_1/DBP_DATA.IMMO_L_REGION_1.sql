CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_l_region_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
region_id STRING(3) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);