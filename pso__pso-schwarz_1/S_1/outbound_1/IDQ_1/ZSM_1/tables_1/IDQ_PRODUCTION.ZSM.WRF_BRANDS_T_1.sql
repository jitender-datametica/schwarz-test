CREATE OR REPLACE TABLE idq_production_zsm.wrf_brands_t_1 (
mandt STRING(3),
brand_id STRING(4) NOT NULL,
language STRING(1) NOT NULL,
brand_descr STRING(30),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (brand_id, language) NOT ENFORCED
);