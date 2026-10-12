CREATE OR REPLACE TABLE smp_production_core.t_ab_campaign_group_kpi_2 (
division_id STRING(100),
country_id STRING(100),
campaign_group_id STRING(100),
campaign_id STRING(100),
campaign_name STRING(500),
cnt_shopper_campaign INTEGER,
cnt_shopper_pre INTEGER,
ntp_shopper_cnt INTEGER,
ntp_shopper_pct STRING(16777216),
lifetime_revenue_val NUMERIC(29,2),
halo_growth_pct NUMERIC(29,5),
ntp_growth_pct NUMERIC(29,5)
);