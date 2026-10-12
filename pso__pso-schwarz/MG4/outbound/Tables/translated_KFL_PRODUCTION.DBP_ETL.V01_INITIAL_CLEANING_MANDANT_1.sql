CREATE OR REPLACE TABLE kfl_production_dbp_etl.v01_initial_cleaning_mandant_1 (
bon_id STRING(100),
bon_nr INTEGER,
wup_id INTEGER,
bon_dat DATE,
mandant_id INTEGER,
hashed_cashier_id STRING(128),
kasse_nr INTEGER,
wrg_id STRING(3),
bon_booking DATETIME,
next_bon_nr INTEGER,
cancellation_amount_gross_local_val NUMERIC(18,4),
kl_art_id INTEGER
);