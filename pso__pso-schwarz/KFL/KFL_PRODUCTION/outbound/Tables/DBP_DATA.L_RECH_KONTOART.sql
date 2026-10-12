CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_rech_kontoart (
mandant_id BIGNUMERIC(38,0) NOT NULL,
rech_kontoart_id STRING(1) COLLATE 'und:ci' NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);