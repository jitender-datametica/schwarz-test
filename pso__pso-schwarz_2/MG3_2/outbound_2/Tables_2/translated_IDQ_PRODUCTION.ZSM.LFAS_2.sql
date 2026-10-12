CREATE OR REPLACE TABLE idq_production_zsm.lfas_2 (
mandt STRING(3) NOT NULL,
lifnr STRING(10) NOT NULL,
land1 STRING(3) NOT NULL,
stceg STRING(20),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, lifnr, land1) NOT ENFORCED
);