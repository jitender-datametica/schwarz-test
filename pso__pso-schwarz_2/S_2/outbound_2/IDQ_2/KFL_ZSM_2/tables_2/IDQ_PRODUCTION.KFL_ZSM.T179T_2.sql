CREATE OR REPLACE TABLE kfl_zsm.t179t_2 (
mandt STRING(3) NOT NULL,
spras STRING(1) NOT NULL,
prodh STRING(18) NOT NULL,
vtext STRING(40),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, prodh, spras) NOT ENFORCED
);