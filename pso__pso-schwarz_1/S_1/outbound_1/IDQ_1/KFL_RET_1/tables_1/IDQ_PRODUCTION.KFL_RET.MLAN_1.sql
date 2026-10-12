CREATE OR REPLACE TABLE idq_production_kfl_ret.mlan_1 (
mandt STRING(3) NOT NULL,
matnr STRING(40) NOT NULL,
aland STRING(3) NOT NULL,
taxm1 STRING(1),
taxm2 STRING(1),
taxm3 STRING(1),
taxm4 STRING(1),
taxm5 STRING(1),
taxm6 STRING(1),
taxm7 STRING(1),
taxm8 STRING(1),
taxm9 STRING(1),
taxim STRING(1),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, matnr, aland) NOT ENFORCED
);