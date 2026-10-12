CREATE OR REPLACE TABLE idq_production_kfl_ret.zek_apollo_hist_2 (
mandant_2 STRING(3) NOT NULL,
matnr STRING(40) NOT NULL,
idnlf STRING(35) NOT NULL,
zzek_apollo_ian STRING(35) NOT NULL,
datab DATE NOT NULL,
datbi DATE NOT NULL,
datae DATE,
loekz STRING(1),
utime TIME,
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandant_2, matnr, idnlf, zzek_apollo_ian) NOT ENFORCED
);