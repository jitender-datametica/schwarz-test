CREATE OR REPLACE TABLE kfl_production_dbp_data.mdl_l_frage (
frage_id INTEGER NOT NULL,
mdl_frage_id STRING(100),
hauptfrage_fg INTEGER,
td_insert TIMESTAMP,
td_update TIMESTAMP
);