CREATE OR REPLACE TABLE smp_production_eval.smar_1019_ldl_pl_store_list (
nr_sklepu STRING(100),
kod STRING(100),
mag STRING(100)
);


CREATE OR REPLACE TABLE smp_production_etl.debug_universe_header_load_ (
advertiser_id STRING(100),
retailer_id STRING(100),
country STRING(100),
universe_name STRING(1000),
universe_id STRING(100),
universe_build_id STRING(100),
universe_build_ts DATETIME,
load_timestamp DATETIME,
update_mode STRING(255)
);