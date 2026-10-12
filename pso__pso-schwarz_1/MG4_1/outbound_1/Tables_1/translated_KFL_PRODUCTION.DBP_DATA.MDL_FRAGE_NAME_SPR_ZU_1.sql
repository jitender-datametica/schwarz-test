CREATE OR REPLACE TABLE kfl_production_dbp_data.mdl_frage_name_spr_zu_1 (
frage_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
frage_name_bez STRING(80) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);