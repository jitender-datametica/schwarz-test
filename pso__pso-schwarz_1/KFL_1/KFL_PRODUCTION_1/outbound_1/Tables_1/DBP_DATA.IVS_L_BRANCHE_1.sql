CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_l_branche_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
branche_id STRING(3) NOT NULL,
branche_bez STRING(40),
spr_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);