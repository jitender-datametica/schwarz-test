CREATE OR REPLACE TABLE smp_production_fe_interface_smp.neodpr_audience_test_2 (
advertiser_id STRING(16777216) NOT NULL,
retailer_id STRING(16777216) NOT NULL,
country_2 STRING(16777216) NOT NULL,
universe_name STRING(16777216) NOT NULL,
shopper_id STRING(16777216),
load_timestamp DATETIME NOT NULL
);


CREATE OR REPLACE TABLE smp_production_etl.debug_universe_shopper_load__2 (
universe_id STRING(100),
universe_build_id STRING(100),
retailer_id STRING(100),
country_2 STRING(100),
shopper_id STRING(100),
load_timestamp DATETIME,
update_mode STRING(255)
);