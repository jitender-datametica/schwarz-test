CREATE OR REPLACE TABLE smp_production_etl.smp_universe_header (
advertiser_id STRING(100) OPTIONS(description='Identifier advertiser smp source'),
retailer_id STRING(100) OPTIONS(description='SMP Retailer Lidl/Kaufland'),
country STRING(100) OPTIONS(description='Country iso code'),
universe_name STRING(1000) OPTIONS(description='Universe Name'),
universe_id STRING(100) OPTIONS(description='Universe ID'),
universe_build_id STRING(100) OPTIONS(description='Universe Build ID'),
universe_build_ts DATETIME OPTIONS(description='Universe Build timestamp_ntz(9)'),
load_timestamp DATETIME OPTIONS(description='timestamp_ntz(9) for loading')
);