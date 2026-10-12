CREATE OR REPLACE TABLE smp_production_eval.tmp_ab_ntp (
division_id STRING(100),
country_id STRING(100),
campaign_group_id STRING(100),
campaign_name STRING(500),
cnt_shopper_campaign INTEGER,
cnt_shopper_pre INTEGER,
ntp_shopper_cnt INTEGER,
ntp_shopper_pct STRING(16777216),
lifetime_revenue_val NUMERIC(29,2)
);