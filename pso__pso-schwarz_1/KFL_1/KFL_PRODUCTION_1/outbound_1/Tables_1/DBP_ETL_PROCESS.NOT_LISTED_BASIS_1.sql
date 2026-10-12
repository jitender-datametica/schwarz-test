CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.not_listed_basis_1 (
mandant_id BIGNUMERIC(38,0),
art_matching_id BIGNUMERIC(38,0),
art_id BIGNUMERIC(38,0),
gtin_id INTEGER,
list_kz STRING(8) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);