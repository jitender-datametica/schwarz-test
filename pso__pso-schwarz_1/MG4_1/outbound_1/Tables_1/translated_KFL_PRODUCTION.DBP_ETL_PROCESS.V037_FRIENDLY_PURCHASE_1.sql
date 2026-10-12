CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.v037_friendly_purchase_1 (
scenario_id INTEGER,
bon_id STRING(100),
bon_nr INTEGER,
wup_id INTEGER,
bon_dat DATE,
mandant_id INTEGER,
hashed_cashier_id STRING(255),
kasse_nr INTEGER,
wrg_id STRING(3),
bon_booking DATETIME,
scenario_fraud_value NUMERIC(18,4),
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
td_update TIMESTAMP,
td_insert TIMESTAMP
);