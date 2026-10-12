CREATE OR REPLACE TABLE kfl_production_dbp_data.sap_dwh_spr_zu_2 (
mandant_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
sap_spr_id STRING(1) NOT NULL,
spr_2 STRING(40) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);