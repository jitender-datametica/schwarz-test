CREATE OR REPLACE TABLE idq_production_kfl_ret.t023t_1 (
mandt STRING(3) NOT NULL,
spras STRING(1) NOT NULL,
matkl STRING(9) NOT NULL,
wgbez STRING(20),
wgbez60 STRING(60),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, spras, matkl) NOT ENFORCED
);