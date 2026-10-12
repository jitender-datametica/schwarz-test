CREATE OR REPLACE TABLE kfl_production_dbp_data.ivs_debitor_immo_objekt_zu_2 (
mandant_id INTEGER NOT NULL,
immo_objekt_id STRING(20) COLLATE 'und:ci' NOT NULL,
debitor_id INTEGER NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);