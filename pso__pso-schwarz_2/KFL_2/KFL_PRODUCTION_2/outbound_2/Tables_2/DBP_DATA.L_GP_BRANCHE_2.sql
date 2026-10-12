CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_gp_branche_2 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
gp_branche_id STRING(4) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);