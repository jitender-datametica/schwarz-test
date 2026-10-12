CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lief_typ_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lief_typ_id STRING(4) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
lief_typ_bez STRING(20) DEFAULT ' ' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);