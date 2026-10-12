CREATE OR REPLACE TABLE idq_production_kfl_ret.zek_owgt_1 (
mandt STRING(3) NOT NULL,
spras STRING(1) NOT NULL,
matkl STRING(9) NOT NULL,
owg STRING(4) NOT NULL,
owg_desc STRING(75),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, spras, matkl, owg) NOT ENFORCED
);