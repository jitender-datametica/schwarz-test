CREATE OR REPLACE TABLE idq_production_kfl_ret.mean (
mandt STRING(3) NOT NULL,
matnr STRING(40) NOT NULL,
meinh STRING(3) NOT NULL,
lfnum STRING(5) NOT NULL,
ean11 STRING(18),
eantp STRING(2),
hpean STRING(1),
sgt_catv STRING(16),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, matnr, meinh, lfnum) NOT ENFORCED
);