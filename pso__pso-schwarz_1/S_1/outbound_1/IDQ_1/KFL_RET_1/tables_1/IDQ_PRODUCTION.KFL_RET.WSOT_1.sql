CREATE OR REPLACE TABLE idq_production_kfl_ret.wsot_1 (
mandt STRING(3) NOT NULL,
skopf STRING(18) NOT NULL,
spras STRING(1) NOT NULL,
vtext STRING(40),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, skopf, spras) NOT ENFORCED
);