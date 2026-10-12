CREATE TABLE IF NOT EXISTS idq_production_kfl_pmr.dmf_prodt (
mandt STRING(3) NOT NULL,
langu STRING(1) NOT NULL,
prod_name STRING(40),
prod_name_uc STRING(40),
prod_id STRING(32) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (langu, mandt, prod_id) NOT ENFORCED
);