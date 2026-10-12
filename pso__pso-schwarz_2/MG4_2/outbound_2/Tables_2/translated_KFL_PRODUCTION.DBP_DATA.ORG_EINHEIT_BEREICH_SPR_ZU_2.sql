CREATE OR REPLACE TABLE kfl_production_dbp_data.org_einheit_bereich_spr_zu_2 (
mandant_id INTEGER NOT NULL,
hr_objekt_bereich_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
hr_objekt_bereich_bez STRING(100) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);