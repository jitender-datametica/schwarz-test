CREATE OR REPLACE TABLE smp_production_core.t_fact_campaign_retail_2 (
division_id STRING(100) NOT NULL,
country_id STRING(100) NOT NULL,
division_country_ref INTEGER,
campaign_id STRING(100) NOT NULL,
campaign_name STRING(500) NOT NULL,
channel_id STRING(100),
day_dt DATE,
cy_week INTEGER,
retail_type_id STRING(100),
sales_gross_val NUMERIC(29,3),
sales_piece_qty NUMERIC(29,3),
source_system_id STRING(100),
create_tmsp DATETIME,
load_id INTEGER
);