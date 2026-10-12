CREATE OR REPLACE TABLE idq_production_zsm.wyt1t_1 (
mandt STRING(3) NOT NULL,
spras STRING(1) NOT NULL,
lifnr STRING(10) NOT NULL,
ltsnr STRING(6) NOT NULL,
ltsbz STRING(20),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, spras, lifnr, ltsnr) NOT ENFORCED
);