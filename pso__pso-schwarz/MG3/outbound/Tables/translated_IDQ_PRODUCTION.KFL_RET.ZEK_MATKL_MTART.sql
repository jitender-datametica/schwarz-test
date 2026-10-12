CREATE OR REPLACE TABLE idq_production_kfl_ret.zek_matkl_mtart (
mandt STRING(3) NOT NULL,
matkl STRING(9) NOT NULL,
mtart STRING(4) NOT NULL,
lead_mtart STRING(1),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, matkl, mtart) NOT ENFORCED
);