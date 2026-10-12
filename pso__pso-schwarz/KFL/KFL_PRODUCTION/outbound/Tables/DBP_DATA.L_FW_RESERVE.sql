CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_fw_reserve (
fw_reserve_id STRING(1) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);