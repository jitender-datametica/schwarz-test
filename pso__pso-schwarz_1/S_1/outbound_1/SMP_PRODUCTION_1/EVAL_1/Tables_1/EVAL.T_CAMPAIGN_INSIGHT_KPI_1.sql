CREATE OR REPLACE TABLE smp_production_eval.t_campaign_insight_kpi_1 (
division_id STRING(100),
country_id STRING(100),
campaign_id STRING(100),
channel_id STRING(100),
campaign_name STRING(500),
campaign_start_dt DATE,
campaign_end_dt DATE,
campaign_status_id STRING(100),
attribution_start_dt DATE,
attribution_end_dt DATE,
new_to_brand_fg INTEGER,
retail_baseline_fg INTEGER,
retail_halo_fg INTEGER,
category_share_fg INTEGER,
lifetime_revenue_fg INTEGER,
campaign_active_fg INTEGER
);