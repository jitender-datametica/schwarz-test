CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.hyg_antwort (
frage_katalog_id STRING(36) COLLATE 'und:ci' NOT NULL,
gj BIGNUMERIC(38,0) NOT NULL,
hyg_antwort_id STRING(36) COLLATE 'und:ci' NOT NULL,
antwort_gruppe_id STRING(36) COLLATE 'und:ci' NOT NULL,
nicht_relevant_fg BIGNUMERIC(38,0),
antwort_pos_id BIGNUMERIC(38,0),
antwort_punktwert BIGNUMERIC(38,0),
antwort_status_fg BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);