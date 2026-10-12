CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_l_sachkonto_gruppe_2 (
sachkonto_gruppe_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
sachkonto_gruppe_bez STRING(40),
spr_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);