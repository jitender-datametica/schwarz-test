CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_zahlsperre_1 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
zahlsperre_id STRING(1) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);