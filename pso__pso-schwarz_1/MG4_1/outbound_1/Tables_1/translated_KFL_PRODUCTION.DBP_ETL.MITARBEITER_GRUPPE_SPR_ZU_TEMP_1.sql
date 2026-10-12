CREATE OR REPLACE TABLE kfl_production_dbp_etl.mitarbeiter_gruppe_spr_zu_temp_1 (
mandant_id INTEGER NOT NULL,
mitarbeiter_gruppe_id STRING(1) COLLATE 'und:ci' NOT NULL,
spr_id INTEGER NOT NULL,
mitarbeiter_gruppe_bez STRING(20) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);