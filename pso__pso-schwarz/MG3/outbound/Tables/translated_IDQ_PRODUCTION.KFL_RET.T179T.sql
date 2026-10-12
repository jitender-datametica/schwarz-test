CREATE OR REPLACE TABLE idq_production_kfl_ret.t179t (
mandt STRING(3) NOT NULL,
spras STRING(1) NOT NULL,
prodh STRING(18) NOT NULL,
vtext STRING(40),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, spras, prodh) NOT ENFORCED
);