CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.hyg_thema_2 (
frage_katalog_id STRING(36) COLLATE 'und:ci' NOT NULL,
hyg_thema_id STRING(36) COLLATE 'und:ci' NOT NULL,
gj BIGNUMERIC(38,0) NOT NULL,
hyg_thema_mutter_id STRING(36) COLLATE 'und:ci' NOT NULL,
hyg_thema_pos_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);