CREATE OR REPLACE TABLE smp_production_etl.smp_universe_shopper (
universe_id STRING(100) OPTIONS(description='Universe ID'),
universe_build_id STRING(100) OPTIONS(description='Universe Build ID'),
retailer_id STRING(100) OPTIONS(description='SMP Retailer Lidl/Kaufland'),
country STRING(100) OPTIONS(description='Country iso code'),
shopper_id STRING(100) OPTIONS(description='Shopper ID'),
cohort_id STRING(100) OPTIONS(description='Cohort ID'),
load_timestamp DATETIME OPTIONS(description='timestamp_ntz(9) for loading')
);