CREATE OR REPLACE TABLE idq_production_kfl_ret.zek_pomwgi_1 (
mandt STRING(3) NOT NULL,
prdha STRING(18) NOT NULL,
zzek_ekpom STRING(2),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, prdha) NOT ENFORCED
);