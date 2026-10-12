CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kostenart_grp (
kostenart_grp_id STRING(30) COLLATE 'und:ci' NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
kostenart_grp_mutter_id STRING(30) COLLATE 'und:ci',
kostenart_grp_id_kons STRING(30) COLLATE 'und:ci',
kl_kostenart_grp_id STRING(30) COLLATE 'und:ci',
ebene_id BIGNUMERIC(38,0),
ebene_pos_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);