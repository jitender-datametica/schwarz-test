CREATE OR REPLACE TABLE kfl_production_dbp_data.org_einheit_spr_zu_2 (
mandant_id INTEGER NOT NULL,
hr_objekt_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
hr_objekt_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);