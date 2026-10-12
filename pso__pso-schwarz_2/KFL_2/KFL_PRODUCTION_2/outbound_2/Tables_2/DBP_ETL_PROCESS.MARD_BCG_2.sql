CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.mard_bcg_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
menge_lgbest_erp_frei_bme NUMERIC(18,3) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);