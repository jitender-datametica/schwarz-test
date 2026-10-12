CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_row_grund_2 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
row_grund_id STRING(3) NOT NULL,
bnk_fg BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);