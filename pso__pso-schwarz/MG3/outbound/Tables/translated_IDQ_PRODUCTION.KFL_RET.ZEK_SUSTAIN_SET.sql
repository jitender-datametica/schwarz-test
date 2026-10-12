CREATE OR REPLACE TABLE idq_production_kfl_ret.zek_sustain_set (
mandt STRING(3) NOT NULL,
matnr STRING(40) NOT NULL,
kzstg STRING(30),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, matnr) NOT ENFORCED
);