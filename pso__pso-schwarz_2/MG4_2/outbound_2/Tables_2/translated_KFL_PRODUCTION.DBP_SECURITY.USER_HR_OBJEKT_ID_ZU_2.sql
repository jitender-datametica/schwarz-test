CREATE OR REPLACE TABLE kfl_production_dbp_security.user_hr_objekt_id_zu_2 (
mandant_id INTEGER NOT NULL,
hr_objekt_ebene1_id INTEGER NOT NULL,
user_id STRING(30) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);