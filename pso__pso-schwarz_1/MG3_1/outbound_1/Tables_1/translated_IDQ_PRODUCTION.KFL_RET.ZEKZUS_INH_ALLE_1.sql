CREATE OR REPLACE TABLE idq_production_kfl_ret.zekzus_inh_alle_1 (
mandt STRING(3) NOT NULL,
matnr STRING(40) NOT NULL,
allergen INTEGER NOT NULL,
udate DATE,
erdat DATE,
uname STRING(12),
uzeit TIME,
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, matnr, allergen) NOT ENFORCED
);