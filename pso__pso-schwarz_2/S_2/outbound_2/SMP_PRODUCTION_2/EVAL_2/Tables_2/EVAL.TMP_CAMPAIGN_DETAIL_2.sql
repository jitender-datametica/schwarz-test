CREATE OR REPLACE TABLE smp_production_eval.tmp_campaign_detail_2 (
division_id STRING(100),
country_id STRING(100),
campaign_group_id STRING(100),
campaign_name STRING(500),
gtin_id INTEGER,
gtin_name STRING(500),
avg_price STRING(16777216),
dat_dt DATE,
campaign_active_fg INTEGER,
control_store_cnt INTEGER,
test_store_cnt INTEGER,
control_bon_cnt INTEGER,
test_bon_cnt INTEGER,
control_gross_val STRING(16777216),
test_gross_val STRING(16777216),
control_qty INTEGER,
test_qty INTEGER
);