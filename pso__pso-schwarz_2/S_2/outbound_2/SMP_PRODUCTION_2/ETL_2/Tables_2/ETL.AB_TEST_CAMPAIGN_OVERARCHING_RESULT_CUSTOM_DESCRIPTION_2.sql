CREATE OR REPLACE TABLE smp_production_etl.ab_test_campaign_overarching_result_custom_description_2 (
description STRING(16777216) OPTIONS(description='utf8 string(INTEGER ) description'),
smp_id STRING(100) OPTIONS(description='utf8 string(INTEGER ) smp_id'),
piq_id STRING(100) OPTIONS(description='utf8 string(INTEGER ) piq_id'),
ab_test_campaign_id STRING(100) OPTIONS(description='utf8 string(INTEGER ) ab_test_campaign_id'),
author STRING(100) OPTIONS(description='utf8 string(INTEGER ) author'),
created_at STRING(100) OPTIONS(description='utf8 string(INTEGER ) created_at'),
file_name STRING(16777216) OPTIONS(description='source file name'),
load_timestamp DATETIME OPTIONS(description='timestamp_ntz(9) for loading')
);