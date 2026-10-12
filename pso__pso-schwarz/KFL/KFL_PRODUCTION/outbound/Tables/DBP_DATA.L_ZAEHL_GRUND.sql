CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_zaehl_grund (
mandant_id BIGNUMERIC(38,0) NOT NULL,
zaehl_grund_id STRING(3) NOT NULL,
zaehl_grund_gruppe_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);