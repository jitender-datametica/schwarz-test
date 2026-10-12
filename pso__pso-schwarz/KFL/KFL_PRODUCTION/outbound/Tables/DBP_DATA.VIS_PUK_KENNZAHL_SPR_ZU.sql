CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vis_puk_kennzahl_spr_zu (
kennzahl_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
kennzahl_bez STRING(100) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);