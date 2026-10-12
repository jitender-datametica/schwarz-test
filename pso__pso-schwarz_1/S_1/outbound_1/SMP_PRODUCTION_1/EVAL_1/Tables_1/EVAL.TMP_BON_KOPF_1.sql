DROP TABLE IF EXISTS smp_production_eval.tmp_bon_kopf_1;
CREATE OR REPLACE TABLE smp_production_eval.tmp_bon_kopf_1 (
division_id STRING(100),
country_id STRING(100),
division_country_ref INTEGER,
bon_id STRING(25),
wup_id INTEGER,
bon_dat DATE,
kundenkarte_id STRING(255),
dat_booking DATE,
cy_week INTEGER,
cy_month INTEGER,
cy_year INTEGER
) CLUSTER BY division_country_ref, bon_dat, wup_id;