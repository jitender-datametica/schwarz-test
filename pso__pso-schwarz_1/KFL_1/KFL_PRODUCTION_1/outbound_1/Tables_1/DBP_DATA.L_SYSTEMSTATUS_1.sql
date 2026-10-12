CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_systemstatus_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
systemstatus_id STRING(5) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);