CREATE OR REPLACE TABLE idq_production_kfl_ret.zek_muki_wb (
mandt STRING(3) NOT NULL,
anrki STRING(40) NOT NULL,
datab DATE,
anrmu STRING(40),
datbi DATE,
lastchange DATE,
username STRING(12),
lasttime STRING(6),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, anrki) NOT ENFORCED
);