CREATE OR REPLACE TABLE smp_production_eval.tmp_shopper_reg_2 (
division_id STRING(100),
country_id STRING(100),
shopper_id STRING(16777216),
shopper_id_ref ARRAY < STRING >,
home_store_id INTEGER,
home_zip_code STRING(16777216),
gender_id STRING(1),
age INTEGER,
active_fg INTEGER,
register_dt DATE
);