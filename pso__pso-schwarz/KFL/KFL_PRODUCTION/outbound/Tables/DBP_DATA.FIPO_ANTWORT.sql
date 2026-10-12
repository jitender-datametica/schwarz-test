CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_antwort (
fipo_antwort_id BIGNUMERIC(38,0) NOT NULL,
fipo_bericht_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
fipo_pruefpunkt_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
fipo_antwort_bwz BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
fipo_antwort_text STRING(300) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
fipo_antwort_num NUMERIC(18,2) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);