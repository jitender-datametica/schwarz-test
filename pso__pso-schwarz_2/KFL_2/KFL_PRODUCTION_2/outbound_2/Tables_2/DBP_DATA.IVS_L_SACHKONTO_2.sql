CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_l_sachkonto_2 (
sachkonto_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
sachkonto_bez STRING(100),
spr_id BIGNUMERIC(38,0),
sachkonto_gruppe_id BIGNUMERIC(38,0) NOT NULL,
plantyp_id BIGNUMERIC(38,0),
plandetail_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);