CREATE OR REPLACE TABLE idq_production_kfl_ret.zek_hwgt (
mandt STRING(3) NOT NULL,
spras STRING(1) NOT NULL,
owg STRING(4) NOT NULL,
hwg STRING(3),
hwg_desc STRING(254),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, spras, owg) NOT ENFORCED
);