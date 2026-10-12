CREATE OR REPLACE TABLE idq_production_kfl_ret.wyt1_2 (
mandt STRING(3) NOT NULL,
lifnr STRING(10) NOT NULL,
ltsnr STRING(6) NOT NULL,
ernam STRING(12),
erdat STRING(24) NOT NULL,
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, lifnr, ltsnr) NOT ENFORCED
);