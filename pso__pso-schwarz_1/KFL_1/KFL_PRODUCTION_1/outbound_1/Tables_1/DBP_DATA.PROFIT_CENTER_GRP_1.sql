CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.profit_center_grp_1 (
pc_grp_id STRING(100) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
pc_hiertyp_id BIGNUMERIC(38,0) NOT NULL,
pc_grp_mutter_id STRING(100) COLLATE 'und:ci',
pc_grp_id_kons STRING(100) COLLATE 'und:ci',
kl_pc_grp_id STRING(50) COLLATE 'und:ci',
ebene_id BIGNUMERIC(38,0),
ebene_pos_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);