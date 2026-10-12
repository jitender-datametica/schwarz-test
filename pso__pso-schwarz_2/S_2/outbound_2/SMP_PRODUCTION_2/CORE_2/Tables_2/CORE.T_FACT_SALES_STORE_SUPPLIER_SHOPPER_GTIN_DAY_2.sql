DROP TABLE IF EXISTS smp_production_core.t_fact_sales_store_supplier_shopper_gtin_day_2;
CREATE OR REPLACE TABLE smp_production_core.t_fact_sales_store_supplier_shopper_gtin_day_2 (
division_id STRING(100) NOT NULL,
country_id STRING(100) NOT NULL,
division_country_ref INTEGER,
day_dt DATE,
store_id_ref INTEGER,
supplier_id_ref INTEGER,
shopper_id_ref STRING(100),
gtin_id STRING(100),
art_id_ref INTEGER,
cy_week INTEGER,
cy_month INTEGER,
cy_year INTEGER,
sales_gross_val NUMERIC(29,5),
sales_piece_qty NUMERIC(29,5),
discount_piece_qty NUMERIC(29,5),
discount_gross_val NUMERIC(29,5),
sales_net_val NUMERIC(29,5),
discount_net_val NUMERIC(29,5),
receipt_cnt INTEGER,
shopper_id STRING(100)
) CLUSTER BY division_id, country_id, day_dt;