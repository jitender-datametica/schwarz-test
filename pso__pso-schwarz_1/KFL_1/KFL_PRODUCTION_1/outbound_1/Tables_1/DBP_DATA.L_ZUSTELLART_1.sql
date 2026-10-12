CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_zustellart_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
zustellart_id STRING(10) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);