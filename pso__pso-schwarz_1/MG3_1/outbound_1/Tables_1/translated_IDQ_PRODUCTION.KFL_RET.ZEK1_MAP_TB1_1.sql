CREATE OR REPLACE TABLE idq_production_kfl_ret.zek1_map_tb1_1 (
mandt STRING(3) NOT NULL,
werks STRING(4) NOT NULL,
matnr STRING(40) NOT NULL,
datab DATE NOT NULL,
datbi DATE NOT NULL,
preis STRING(1),
lastchange DATE,
lasttime TIME,
username STRING(12),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, matnr, werks, datab) NOT ENFORCED
);