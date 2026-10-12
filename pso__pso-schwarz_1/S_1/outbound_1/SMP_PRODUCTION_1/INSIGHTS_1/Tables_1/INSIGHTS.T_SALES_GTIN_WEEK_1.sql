DROP TABLE IF EXISTS smp_production_insights.t_sales_gtin_week_1;
CREATE OR REPLACE TABLE smp_production_insights.t_sales_gtin_week_1 (
division_id STRING(100) NOT NULL,
country_id STRING(100) NOT NULL,
cy_week INTEGER,
gtin_id STRING(100),
gtin_name STRING(500),
article_id_list STRING(1000),
article_parent_id_list STRING(1000),
sales_gross_val NUMERIC(29,2),
sales_piece_qty NUMERIC(29,5),
store_cnt INTEGER,
gtin_price NUMERIC(29,2),
cy_week_start_dt DATE
) CLUSTER BY division_id, country_id, gtin_id;