CREATE OR REPLACE TABLE idq_production_kfl_zsm.t179_1 (
mandt STRING(3) NOT NULL,
prodh STRING(18) NOT NULL,
stufe NUMERIC(1,0),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, prodh) NOT ENFORCED
);