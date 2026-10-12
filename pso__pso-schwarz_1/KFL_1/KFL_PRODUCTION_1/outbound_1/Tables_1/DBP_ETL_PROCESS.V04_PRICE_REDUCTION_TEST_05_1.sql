CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.v04_price_reduction_test_05_1 (
scenario_id INTEGER,
bon_id STRING(100),
bon_nr BIGNUMERIC(38,0),
bon_dat DATE,
wup_id BIGNUMERIC(38,0),
mandant_id BIGNUMERIC(38,0),
kasse_nr BIGNUMERIC(38,0),
wrg_id STRING(3),
bon_booking DATETIME,
hashed_cashier_id STRING(255),
scenario_fraud_value BIGNUMERIC(31,4),
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
td_update TIMESTAMP,
td_insert TIMESTAMP
);