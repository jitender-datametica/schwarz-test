CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_nachrichtenklasse (
mandant_id BIGNUMERIC(38,0) NOT NULL,
nachrichtenklasse_id STRING(1) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);