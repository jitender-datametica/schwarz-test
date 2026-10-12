DROP TABLE IF EXISTS smp_production_eval.tmp_delta_2;
CREATE OR REPLACE TABLE smp_production_eval.tmp_delta_2 (
division_id STRING(100),
country_id STRING(100),
division_country_ref INTEGER,
store_id_ref INTEGER,
day_dt DATE
) CLUSTER BY day_dt;