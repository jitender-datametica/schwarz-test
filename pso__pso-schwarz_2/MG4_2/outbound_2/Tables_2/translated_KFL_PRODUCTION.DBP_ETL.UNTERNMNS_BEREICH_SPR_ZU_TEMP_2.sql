CREATE OR REPLACE TABLE kfl_production_dbp_etl.unternmns_bereich_spr_zu_temp_2 (
mandant_id INTEGER NOT NULL,
unternehmens_bereich_id STRING(2) COLLATE 'und:ci' NOT NULL,
spr_id INTEGER NOT NULL,
unternehmens_bereich_bez STRING(60) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);