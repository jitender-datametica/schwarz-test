CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_we_message_status_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
we_message_status_id STRING(10) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);