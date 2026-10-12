CREATE OR REPLACE TABLE idq_production_kfl_ret.zrs_displ_pfand (
mandt STRING(3) NOT NULL,
dmatnr STRING(18) NOT NULL,
kmatnr STRING(18) NOT NULL,
datab DATE NOT NULL,
umrez NUMERIC(5,0),
umren NUMERIC(5,0),
activ STRING(1),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, dmatnr, kmatnr, datab) NOT ENFORCED
);