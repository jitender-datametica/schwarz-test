CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_gj_variante_1 (
gj_variante_id STRING(2) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
gj_variante_bez STRING(50) COLLATE 'und:ci',
krk_id STRING(4) COLLATE 'und:ci',
kl_gj_fg BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);