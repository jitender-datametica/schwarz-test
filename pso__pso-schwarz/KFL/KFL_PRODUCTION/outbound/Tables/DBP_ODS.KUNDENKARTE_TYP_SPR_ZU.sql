CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.kundenkarte_typ_spr_zu (
kundenkarte_typ_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
kundenkarte_typ_bez STRING(50) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);