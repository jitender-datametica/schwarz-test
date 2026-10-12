CREATE OR REPLACE TABLE smp_production_insights.test_dooh_campaign_registration_2 (
campaign_name STRING(16777216) NOT NULL,
campaign_start_date DATE,
campaign_end_date DATE,
division_id STRING(16777216),
country_id STRING(16777216),
product_list STRING(16777216),
test_store_list STRING(16777216),
control_store_list STRING(16777216),
budget_spend FLOAT64,
active_fg INTEGER,
date_updated DATETIME,
PRIMARY KEY (campaign_name) NOT ENFORCED
);