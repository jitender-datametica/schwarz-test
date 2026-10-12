CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.hyg_antwort_gruppe_2 (
frage_katalog_id STRING(36) COLLATE 'und:ci' NOT NULL,
antwort_gruppe_id STRING(36) COLLATE 'und:ci' NOT NULL,
gj BIGNUMERIC(38,0) NOT NULL,
antwort_gruppe_typ_id BIGNUMERIC(38,0),
max_wert BIGNUMERIC(38,0),
min_wert BIGNUMERIC(38,0),
keine_antwort_fg BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);