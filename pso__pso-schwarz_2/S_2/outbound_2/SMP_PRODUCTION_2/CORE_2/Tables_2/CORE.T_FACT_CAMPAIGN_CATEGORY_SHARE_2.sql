CREATE OR REPLACE TABLE smp_production_core.t_fact_campaign_category_share_2 (
division_id STRING(100) NOT NULL,
country_id STRING(100) NOT NULL,
division_country_ref INTEGER,
campaign_id STRING(100) NOT NULL,
campaign_name STRING(500) NOT NULL,
day_dt DATE,
sales_gross_val_level_1 NUMERIC(29,3),
sales_gross_val_supplier_level_1 NUMERIC(29,3),
sales_gross_val_level_2 NUMERIC(29,3),
sales_gross_val_supplier_level_2 NUMERIC(29,3),
sales_gross_val_level_3 NUMERIC(29,3),
sales_gross_val_supplier_level_3 NUMERIC(29,3)
);