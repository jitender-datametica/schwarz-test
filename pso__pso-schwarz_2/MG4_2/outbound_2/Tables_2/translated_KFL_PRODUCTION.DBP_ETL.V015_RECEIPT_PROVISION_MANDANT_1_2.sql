CREATE OR REPLACE TABLE kfl_production_dbp_etl.v015_receipt_provision_mandant_1_2 (
scenario_id INTEGER,
bon_id STRING(100),
bon_nr INTEGER,
wup_id INTEGER,
bon_dat DATE,
mandant_id INTEGER,
hashed_cashier_id STRING(128),
kasse_nr INTEGER,
wrg_id STRING(3),
bon_booking DATETIME,
scenario_fraud_value NUMERIC(29,4),
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='mat-View for Scenario 15: receipt provision');