CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.hyg_spr_zu_2 (
hyg_text_id STRING(36) COLLATE 'und:ci' NOT NULL,
gj BIGNUMERIC(38,0) NOT NULL,
hyg_ref_id STRING(36) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
hyg_column STRING(30) COLLATE 'und:ci' NOT NULL,
hyg_text STRING(500) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);