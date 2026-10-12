CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_l_zustaendig_typ_2 (
zustaendig_typ_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
zustaendig_typ_bez STRING(40),
spr_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);