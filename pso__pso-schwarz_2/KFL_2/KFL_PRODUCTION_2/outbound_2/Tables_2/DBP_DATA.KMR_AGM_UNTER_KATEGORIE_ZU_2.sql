CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kmr_agm_unter_kategorie_zu_2 (
kmr_quelle_id BIGNUMERIC(38,0) NOT NULL,
kmr_agm_id BIGNUMERIC(38,0) NOT NULL,
umfrage_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
kmr_unter_kategorie_id BIGNUMERIC(38,0),
agm_sw NUMERIC(9,4) DEFAULT 1 NOT NULL,
kmr_teilbereich_frage_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);