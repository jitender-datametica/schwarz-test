CREATE OR REPLACE TABLE kfl_production_dbp_data.l_unternmns_bereich (
mandant_id INTEGER NOT NULL,
unternehmens_bereich_id STRING(2) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);