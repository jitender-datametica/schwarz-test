CREATE OR REPLACE TABLE kfl_production_dbp_data.l_mitarbeiter_gruppe (
mandant_id INTEGER NOT NULL,
mitarbeiter_gruppe_id STRING(1) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);