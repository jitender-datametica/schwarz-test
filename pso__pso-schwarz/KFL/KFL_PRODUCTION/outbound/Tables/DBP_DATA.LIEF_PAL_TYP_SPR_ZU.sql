CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lief_pal_typ_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lief_pal_typ_id STRING(1) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
lief_pal_typ_bez STRING(30) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);