DROP TABLE IF EXISTS smp_production_core.t_supplier_ltr_receipt_2;
CREATE OR REPLACE TABLE smp_production_core.t_supplier_ltr_receipt_2 (
division_id STRING(100) NOT NULL,
country_id STRING(100) NOT NULL,
day_dt DATE NOT NULL,
supplier_id_ref INTEGER NOT NULL,
shopper_id_ref STRING(100) NOT NULL,
bon_id STRING(1000),
sales_gross_val NUMERIC(29,5)
) CLUSTER BY division_id, country_id, day_dt;