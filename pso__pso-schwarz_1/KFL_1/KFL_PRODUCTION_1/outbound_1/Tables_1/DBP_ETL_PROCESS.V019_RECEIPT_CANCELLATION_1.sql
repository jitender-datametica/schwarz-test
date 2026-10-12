CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.v019_receipt_cancellation_1 (
scenario_id INTEGER,
bon_id STRING(100),
bon_nr BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0),
bon_dat DATE,
mandant_id BIGNUMERIC(38,0),
hashed_cashier_id STRING(255),
kasse_nr BIGNUMERIC(38,0),
wrg_id STRING(3),
bon_booking DATETIME,
scenario_fraud_value NUMERIC(18,4),
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='mat-View for Scenario 19: receipt cancellation');