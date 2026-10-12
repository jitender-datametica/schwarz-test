CREATE OR REPLACE TABLE kfl_production_dbp_etl.base_table_time_diff_2 (
bon_id STRING(100),
bon_nr INTEGER,
wup_id INTEGER,
bon_dat DATE,
mandant_id INTEGER,
hashed_cashier_id STRING(255),
kasse_nr INTEGER,
wrg_id STRING(3),
bon_booking DATETIME,
scenario_fraud_value NUMERIC(18,4)
);