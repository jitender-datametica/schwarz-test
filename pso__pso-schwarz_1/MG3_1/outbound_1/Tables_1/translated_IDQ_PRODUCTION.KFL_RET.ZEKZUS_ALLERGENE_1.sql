CREATE OR REPLACE TABLE idq_production_kfl_ret.zekzus_allergene_1 (
mandt STRING(3) NOT NULL,
allergen INTEGER NOT NULL,
alltyp STRING(1) NOT NULL,
spras STRING(1) NOT NULL,
alltxt STRING(30),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, allergen, alltyp, spras) NOT ENFORCED
);