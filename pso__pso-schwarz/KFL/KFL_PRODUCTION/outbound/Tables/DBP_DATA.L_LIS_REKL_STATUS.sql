CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_lis_rekl_status (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lis_rekl_status_id STRING(10) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);