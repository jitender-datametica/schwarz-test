CREATE OR REPLACE TABLE idq_production_kfl_ret.t6wst_1 (
mandt STRING(3) NOT NULL,
saiso STRING(4) NOT NULL,
spras STRING(1) NOT NULL,
vtext STRING(20),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, saiso, spras) NOT ENFORCED
);