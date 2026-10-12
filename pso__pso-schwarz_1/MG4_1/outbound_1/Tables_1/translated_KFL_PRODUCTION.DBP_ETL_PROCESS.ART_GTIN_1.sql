CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.art_gtin_1 (
art_id INTEGER,
mandant_id INTEGER,
gtin_id INTEGER,
gtin_typ_id STRING(4) COLLATE 'und:ci',
haupt_gtin_fg INTEGER,
td_insert TIMESTAMP,
td_update TIMESTAMP
);