CREATE OR REPLACE TABLE kfl_production_dbp_data.kmr_agm_unter_kategorie_zu_1 (
kmr_quelle_id INTEGER NOT NULL,
kmr_agm_id INTEGER NOT NULL,
umfrage_id INTEGER DEFAULT - 1 NOT NULL,
kmr_unter_kategorie_id INTEGER,
agm_sw NUMERIC(9,4) DEFAULT 1 NOT NULL,
kmr_teilbereich_frage_id INTEGER,
td_insert TIMESTAMP,
td_update TIMESTAMP
);