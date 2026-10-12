CREATE OR REPLACE TABLE idq_production_kfl_ret.zekzus_lagerbed (
mandt STRING(3) NOT NULL,
lbed INTEGER NOT NULL,
spras STRING(1) NOT NULL,
lagbed STRING(80),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, lbed, spras) NOT ENFORCED
);