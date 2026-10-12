CREATE OR REPLACE TABLE kfl_production_dbp_data.mcx_antwort_kategorie_zu (
antwort_id INTEGER NOT NULL,
umfrage_id INTEGER DEFAULT - 1 NOT NULL,
kat_id INTEGER NOT NULL,
gesamt_fg INTEGER NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);