CREATE OR REPLACE TABLE idq_production_kfl_ret.mamt (
mandt STRING(3) NOT NULL,
matnr STRING(40) NOT NULL,
spras STRING(1) NOT NULL,
meinh STRING(3) NOT NULL,
mtxid STRING(2) NOT NULL,
lfdnr NUMERIC(2,0) NOT NULL,
maktm STRING(40),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, matnr, spras, meinh, mtxid, lfdnr) NOT ENFORCED
);