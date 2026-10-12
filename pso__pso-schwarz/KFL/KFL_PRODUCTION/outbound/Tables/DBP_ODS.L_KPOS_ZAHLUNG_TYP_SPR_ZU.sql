CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.l_kpos_zahlung_typ_spr_zu (
kpos_zahlung_typ_id STRING(4) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
kpos_zahlung_typ_bez STRING(50) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);