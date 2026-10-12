CREATE OR REPLACE TABLE smp_production_core.t_campaign_insight_kpi_1 (
division_id STRING(100) NOT NULL,
country_id STRING(100) NOT NULL,
campaign_id STRING(100) NOT NULL,
channel_id STRING(100),
campaign_name STRING(500) NOT NULL,
campaign_start_dt DATE,
campaign_end_dt DATE,
campaign_status_id STRING(100),
attribution_start_dt DATE,
attribution_end_dt DATE,
retail_baseline_fg INTEGER,
retail_halo_fg INTEGER,
category_share_fg INTEGER,
lifetime_revenue_fg INTEGER,
campaign_active_fg INTEGER,
ntp_fg INTEGER
);