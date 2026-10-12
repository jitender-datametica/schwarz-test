CREATE OR REPLACE TABLE kfl_production_dbp_data.mcx_frage_spr_zu (
frage_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
umfrage_id INTEGER DEFAULT - 1 NOT NULL,
frage_bez STRING(255) COLLATE 'und:ci' NOT NULL,
frage_typ STRING(50) COLLATE 'und:ci' NOT NULL,
frage_alias STRING(50) COLLATE 'und:ci' NOT NULL,
frage_s_code STRING(50) COLLATE 'und:ci' DEFAULT '' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);