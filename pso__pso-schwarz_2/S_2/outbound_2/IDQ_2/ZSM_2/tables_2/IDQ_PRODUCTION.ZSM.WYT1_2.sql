CREATE OR REPLACE TABLE idq_production_zsm.wyt1_2 (
mandt STRING(3),
lifnr STRING(10) NOT NULL,
ltsnr STRING(6) NOT NULL,
ernam STRING(12),
erdat DATE,
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (lifnr, ltsnr) NOT ENFORCED
);