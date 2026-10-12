CREATE OR REPLACE TABLE idq_production_kfl_ret.zekzus_lagerbed_1 (
mandt STRING(3) NOT NULL,
lbed NUMERIC(3,0) NOT NULL,
spras STRING(1) NOT NULL,
lagbed STRING(80),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, lbed, spras) NOT ENFORCED
);