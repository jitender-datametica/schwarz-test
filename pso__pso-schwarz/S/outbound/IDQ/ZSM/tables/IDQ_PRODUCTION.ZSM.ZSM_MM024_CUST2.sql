CREATE OR REPLACE TABLE idq_production_zsm.zsm_mm024_cust2 (
mandt STRING(3) NOT NULL,
ktokk STRING(4) NOT NULL,
aktiv STRING(1),
ktokd STRING(4),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, ktokk) NOT ENFORCED
);