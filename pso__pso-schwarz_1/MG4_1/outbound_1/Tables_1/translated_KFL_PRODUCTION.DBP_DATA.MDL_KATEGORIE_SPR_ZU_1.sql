CREATE OR REPLACE TABLE kfl_production_dbp_data.mdl_kategorie_spr_zu_1 (
kategorie_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
kategorie_bez STRING(80) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);