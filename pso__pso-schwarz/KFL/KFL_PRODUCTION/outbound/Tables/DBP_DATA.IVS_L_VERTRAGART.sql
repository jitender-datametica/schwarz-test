CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_l_vertragart (
mandant_id BIGNUMERIC(38,0) NOT NULL,
vertragart_id STRING(3) NOT NULL,
vertragart_bez STRING(40),
spr_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);