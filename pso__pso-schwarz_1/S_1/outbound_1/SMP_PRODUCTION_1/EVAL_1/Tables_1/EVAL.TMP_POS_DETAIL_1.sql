DROP TABLE IF EXISTS smp_production_eval.tmp_pos_detail_1;
CREATE OR REPLACE TABLE smp_production_eval.tmp_pos_detail_1 (
division_id STRING(100),
country_id STRING(100),
division_country_ref INTEGER,
day_dt DATE,
cy_week INTEGER,
cy_month INTEGER,
cy_year INTEGER,
store_id_ref INTEGER,
art_id_ref INTEGER,
gtin_id STRING(100) COLLATE 'und:ci',
shopper_id_ref STRING(100),
supplier_id_ref INTEGER,
bon_id STRING(90),
sales_gross_val_ NUMERIC(29,5),
sales_piece_qty NUMERIC(29,5),
discount_piece_qty NUMERIC(29,5)
) CLUSTER BY bon_id;