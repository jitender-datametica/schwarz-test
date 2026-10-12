CREATE OR REPLACE TABLE smp_production_etl.dpr_1555_incrementality_test (
shopper_id STRING(16777216) NOT NULL,
cohort_id STRING(16777216) NOT NULL,
campaign_id STRING(16777216) NOT NULL,
campaign_name STRING(16777216) NOT NULL,
campaign_group_id STRING(16777216) NOT NULL,
campaign_group_name STRING(16777216) NOT NULL,
campaign_start DATETIME NOT NULL,
campaign_end DATETIME NOT NULL
);