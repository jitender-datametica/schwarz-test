CREATE OR REPLACE TABLE kfl_production_dbp_data.l_mitarbeiter_abwesenh_2 (
mandant_id INTEGER NOT NULL,
abwesenheit_id STRING(4) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);