CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_gp_fehlerart (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
gp_fehlerart_id STRING(1) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);