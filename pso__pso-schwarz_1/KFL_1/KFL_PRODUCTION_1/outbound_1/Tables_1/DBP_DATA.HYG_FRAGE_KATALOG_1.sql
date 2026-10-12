CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.hyg_frage_katalog_1 (
frage_katalog_id STRING(36) COLLATE 'und:ci' NOT NULL,
gj BIGNUMERIC(38,0) NOT NULL,
frage_katalog_bez STRING(255) COLLATE 'und:ci',
frage_katalog_bez_lang STRING(255) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);