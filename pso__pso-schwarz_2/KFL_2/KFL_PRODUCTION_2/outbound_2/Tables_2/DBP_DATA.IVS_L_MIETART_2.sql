CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_l_mietart_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
mietart_id STRING(2) NOT NULL,
spr_id BIGNUMERIC(38,0),
mietart_bez STRING(40),
td_insert TIMESTAMP,
td_update TIMESTAMP
);