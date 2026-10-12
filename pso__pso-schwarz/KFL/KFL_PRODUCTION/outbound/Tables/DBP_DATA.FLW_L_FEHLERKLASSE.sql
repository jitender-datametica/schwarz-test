CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_fehlerklasse (
mandant_id BIGNUMERIC(38,0) NOT NULL,
fehlerklasse_id BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
fehlerklasse_kennzahl BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);