DROP TABLE IF EXISTS smp_production_eval.tmp_pos_receiptheader_2;
CREATE OR REPLACE TABLE smp_production_eval.tmp_pos_receiptheader_2 (
division_id STRING(100),
country_id STRING(100),
division_country_ref INTEGER,
client_id INTEGER,
loc_sid INTEGER,
dwh_cal_dt DATE,
register_id INTEGER,
receipt_dt DATE,
receipt_id INTEGER,
receipt_tmsp DATETIME,
customer_sid INTEGER,
cy_week INTEGER,
cy_month INTEGER,
cy INTEGER,
bon_id STRING(90)
) CLUSTER BY bon_id;