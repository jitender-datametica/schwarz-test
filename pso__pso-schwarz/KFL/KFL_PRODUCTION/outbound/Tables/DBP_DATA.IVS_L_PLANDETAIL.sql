CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_l_plandetail (
plandetail_id BIGNUMERIC(38,0) NOT NULL,
plantyp_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
plandetail_bez STRING(100),
spr_id BIGNUMERIC(38,0) NOT NULL,
dat_extrakt DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);