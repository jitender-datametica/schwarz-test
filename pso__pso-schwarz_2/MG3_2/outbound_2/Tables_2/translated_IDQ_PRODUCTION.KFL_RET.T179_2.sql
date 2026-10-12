CREATE OR REPLACE TABLE idq_production_kfl_ret.t179_2 (
mandt STRING(3) NOT NULL,
prodh STRING(18) NOT NULL,
stufe INTEGER,
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, prodh) NOT ENFORCED
);