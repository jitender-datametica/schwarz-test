CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.ek_sort_art_matching_zu (
mandant_id BIGNUMERIC(38,0),
art_matching_id BIGNUMERIC(38,0),
kombi_art_id STRING(5000),
kombi_art_nielsen_id STRING(5000),
kombi_gtin_id STRING(5000),
dat_von DATE,
dat_bis DATE
);