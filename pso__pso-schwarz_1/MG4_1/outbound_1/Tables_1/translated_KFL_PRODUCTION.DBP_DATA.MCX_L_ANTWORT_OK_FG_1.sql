CREATE OR REPLACE TABLE kfl_production_dbp_data.mcx_l_antwort_ok_fg_1 (
antwort_id INTEGER NOT NULL,
umfrage_id INTEGER DEFAULT - 1 NOT NULL,
ok_fg INTEGER DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);