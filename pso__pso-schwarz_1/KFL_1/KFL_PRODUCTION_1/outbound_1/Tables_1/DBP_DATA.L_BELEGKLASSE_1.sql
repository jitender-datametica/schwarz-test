CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_belegklasse_1 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
belegklasse_id STRING(5) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);