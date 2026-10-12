CREATE OR REPLACE TABLE idq_production_kfl_ret.zek_regioartpro_1 (
mandt STRING(3) NOT NULL,
lifnr STRING(10) NOT NULL,
adrnr STRING(10) NOT NULL,
matnr STRING(40) NOT NULL,
loekz STRING(1) NOT NULL,
aenam STRING(12),
aedat DATE,
aetim TIME,
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, lifnr, adrnr, matnr) NOT ENFORCED
);