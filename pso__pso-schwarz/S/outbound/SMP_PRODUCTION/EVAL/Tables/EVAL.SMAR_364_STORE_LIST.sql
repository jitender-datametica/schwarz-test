CREATE OR REPLACE TABLE smp_production_eval.smar_364_store_list (
store_id STRING(16777216),
wh INTEGER
);


CREATE OR REPLACE TABLE smp_production_etl.debug_universe_load_ (
universe_id STRING(100),
universe_build_id STRING(100),
retailer_id STRING(100),
country STRING(100),
shopper_id STRING(100),
cohort_id STRING(100),
load_timestamp DATETIME,
update_mode STRING(255)
);