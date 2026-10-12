CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vis_puk_thema_spr_zu_2 (
thema_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
thema_bez STRING(50) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);