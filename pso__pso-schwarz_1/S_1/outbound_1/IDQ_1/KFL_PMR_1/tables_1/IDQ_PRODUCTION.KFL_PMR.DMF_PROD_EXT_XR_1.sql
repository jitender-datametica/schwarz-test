CREATE OR REPLACE TABLE idq_production_kfl_pmr.dmf_prod_ext_xr_1 (
mandt STRING(3) NOT NULL,
ext_prod_id STRING(60) NOT NULL,
log_sys_id NUMERIC(5,0) NOT NULL,
prod_id STRING(255),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, ext_prod_id, log_sys_id) NOT ENFORCED
);