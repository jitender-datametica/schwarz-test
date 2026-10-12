CREATE OR REPLACE TABLE smp_production_etl_process.t_sales_delta_1 (
division_id STRING(100),
country_id STRING(100),
division_country_ref INTEGER,
upd_from_tmsp DATETIME,
upd_to_tmsp DATETIME,
type STRING(13)
);