CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_vorgangsklasse (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
vorgangsklasse_id STRING(5) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);