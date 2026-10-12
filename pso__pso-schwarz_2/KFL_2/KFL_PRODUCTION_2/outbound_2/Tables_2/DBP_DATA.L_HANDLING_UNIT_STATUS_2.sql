CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_handling_unit_status_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
hu_status_id STRING(4) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);