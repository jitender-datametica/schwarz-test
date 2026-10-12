CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_objektart_spr_zu (
objektart_id STRING(1) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
objektart_bez STRING(40),
td_insert TIMESTAMP,
td_update TIMESTAMP
);