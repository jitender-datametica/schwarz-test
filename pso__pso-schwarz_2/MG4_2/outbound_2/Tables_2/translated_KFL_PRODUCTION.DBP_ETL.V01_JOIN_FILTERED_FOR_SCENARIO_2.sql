CREATE OR REPLACE TABLE kfl_production_dbp_etl.v01_join_filtered_for_scenario_2 (
bon_id STRING(100),
bon_nr INTEGER,
wup_id INTEGER,
bon_dat DATE,
mandant_id INTEGER,
kasse_nr INTEGER,
wrg_id STRING(3),
bon_booking DATETIME,
hashed_cashier_id STRING(255),
cancellation_amount_gross_local_val NUMERIC(18,4)
);