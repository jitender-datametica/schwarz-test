CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.art_art_nielsen_prepare_kmo_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
art_nielsen_id BIGNUMERIC(38,0) NOT NULL,
gtin_id NUMERIC(26,0) NOT NULL,
art_matching_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);