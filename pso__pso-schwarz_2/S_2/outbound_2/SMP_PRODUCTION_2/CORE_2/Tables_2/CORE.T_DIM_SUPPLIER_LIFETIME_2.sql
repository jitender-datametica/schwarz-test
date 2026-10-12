CREATE OR REPLACE TABLE smp_production_core.t_dim_supplier_lifetime_2 (
division_id STRING(100) NOT NULL,
country_id STRING(100) NOT NULL,
division_country_ref INTEGER NOT NULL,
supplier_id_ref INTEGER,
pos_range_from DATE,
pos_range_to DATE,
sales_gross_val NUMERIC(29,5),
bon_cnt INTEGER,
shopper_cnt INTEGER,
shopper_more_than_1_bon_cnt INTEGER,
create_date DATE
);