CREATE OR REPLACE TABLE idq_production_kfl_ret.zek_owg (
mandt STRING(3) NOT NULL,
matkl STRING(9) NOT NULL,
owg STRING(4) NOT NULL,
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, matkl, owg) NOT ENFORCED
);