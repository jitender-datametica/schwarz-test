CREATE OR REPLACE TABLE kfl_production_dbp_data.mcx_l_frage_2 (
frage_id INTEGER NOT NULL,
umfrage_id INTEGER DEFAULT - 1 NOT NULL,
frage_ex_typ INTEGER NOT NULL,
frage_status INTEGER NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);