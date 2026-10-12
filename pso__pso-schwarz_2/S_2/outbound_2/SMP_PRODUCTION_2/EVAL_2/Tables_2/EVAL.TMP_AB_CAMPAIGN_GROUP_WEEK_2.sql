CREATE OR REPLACE TABLE smp_production_eval.tmp_ab_campaign_group_week_2 (
division_id STRING(100),
country_id STRING(100),
campaign_group_id STRING(100),
campaign_name STRING(500),
cy_week INTEGER,
campaign_fg INTEGER,
halo_level_id INTEGER,
period STRING(8),
cell_group_id STRING(10),
shopper_cnt INTEGER,
control_unique_shopper INTEGER,
test_unique_shopper INTEGER,
sales_gross_val NUMERIC(29,5),
retail_halo_pct NUMERIC(29,8),
retail_baseline_pct NUMERIC(29,8)
);