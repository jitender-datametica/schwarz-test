CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_l_miet_region_1 (
miet_region_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
bl_id STRING(3) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
miet_region_bez STRING(40),
bl_bez STRING(40),
td_insert TIMESTAMP,
td_update TIMESTAMP
);