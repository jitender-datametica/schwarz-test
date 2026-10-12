CREATE OR REPLACE TABLE idq_production_sp_mep.makt (
mandt STRING(3) NOT NULL,
matnr STRING(18) NOT NULL,
spras STRING(1) NOT NULL,
maktx STRING(40),
maktg STRING(40),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, matnr, spras) NOT ENFORCED
);