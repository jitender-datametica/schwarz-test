CREATE OR REPLACE TABLE smp_production_eval.tmp_campaign_retail_2 (
division_id STRING(100),
country_id STRING(100),
division_country_ref INTEGER,
campaign_id STRING(100),
campaign_name STRING(500),
channel_id STRING(100),
day_dt DATE,
cy_week INTEGER,
retail_type_id STRING(25),
sales_gross_val NUMERIC(29,5),
sales_piece_qty NUMERIC(29,5),
pre_fg INTEGER,
source_system_id STRING(3),
create_tmsp DATETIME,
load_id INTEGER
);