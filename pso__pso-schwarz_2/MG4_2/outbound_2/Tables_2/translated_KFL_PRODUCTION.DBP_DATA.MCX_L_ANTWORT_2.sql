CREATE OR REPLACE TABLE kfl_production_dbp_data.mcx_l_antwort_2 (
antwort_id INTEGER NOT NULL,
umfrage_id INTEGER DEFAULT - 1 NOT NULL,
frage_id INTEGER NOT NULL,
scale_id INTEGER NOT NULL,
antwort_gewichtung INTEGER NOT NULL,
datzeit_aend DATETIME NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);