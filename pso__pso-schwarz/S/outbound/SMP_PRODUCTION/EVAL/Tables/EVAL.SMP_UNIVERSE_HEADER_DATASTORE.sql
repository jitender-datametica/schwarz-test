CREATE OR REPLACE TABLE smp_production_eval.smp_universe_header_datastore (
advertiser_id STRING(100),
retailer_id STRING(100),
country STRING(100),
universe_name STRING(1000),
universe_id STRING(100),
universe_build_id STRING(100),
universe_build_ts DATETIME,
load_timestamp DATETIME,
load_tmsp DATETIME
);