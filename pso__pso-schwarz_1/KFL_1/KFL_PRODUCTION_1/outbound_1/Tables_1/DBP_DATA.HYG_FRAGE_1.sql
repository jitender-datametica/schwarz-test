CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.hyg_frage_1 (
frage_katalog_id STRING(36) COLLATE 'und:ci' NOT NULL,
gj BIGNUMERIC(38,0) NOT NULL,
hyg_frage_id STRING(36) COLLATE 'und:ci' NOT NULL,
antwort_gruppe_id STRING(36) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);