CREATE OR REPLACE TABLE idq_production_zsm.zsm_coneg_cntry_1 (
mandt STRING(3) NOT NULL,
lifnr STRING(10) NOT NULL,
conegot_country STRING(3) NOT NULL,
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, lifnr, conegot_country) NOT ENFORCED
);