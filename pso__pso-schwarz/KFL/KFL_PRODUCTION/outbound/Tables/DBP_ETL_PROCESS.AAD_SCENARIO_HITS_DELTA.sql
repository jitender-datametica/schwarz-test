CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.aad_scenario_hits_delta (
mandant_id BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0),
hashed_cashier_id STRING(255),
bon_dat DATE,
bon_id STRING(100)
);