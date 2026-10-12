CREATE OR REPLACE TABLE kfl_production_dbp_data.mdl_frage_spr_zu_2 (
frage_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
frage_bez STRING(200) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);