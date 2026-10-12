CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.art_gtin_2 (
art_id BIGNUMERIC(38,0),
mandant_id BIGNUMERIC(38,0),
gtin_id BIGNUMERIC(38,0),
gtin_typ_id STRING(4) COLLATE 'und:ci',
haupt_gtin_fg BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);