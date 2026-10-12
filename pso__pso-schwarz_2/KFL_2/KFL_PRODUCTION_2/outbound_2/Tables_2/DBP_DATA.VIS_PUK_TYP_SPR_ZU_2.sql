CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vis_puk_typ_spr_zu_2 (
puk_typ_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
puk_typ_bez STRING(50) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);