CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.fanquote_basis_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
matching_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
kjwo_update BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);