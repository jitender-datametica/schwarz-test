CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_buch_grund_int (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
buch_grund_int_id STRING(3) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);