CREATE OR REPLACE TABLE kfl_production_dbp_data.mitarbeiter_abwesenh_spr_zu_2 (
mandant_id INTEGER NOT NULL,
abwesenheit_id STRING(4) COLLATE 'und:ci' NOT NULL,
spr_id INTEGER NOT NULL,
abwesenheit_bez STRING(30) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);