CREATE OR REPLACE TABLE kfl_production_dbp_data.mdl_antwort_spr_zu_2 (
frage_id INTEGER NOT NULL,
antwort_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
antwort_bez STRING(400) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);