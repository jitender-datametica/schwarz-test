CREATE OR REPLACE TABLE idq_production_kfl_ret.sapsll_maritc_1 (
mandt STRING(3) NOT NULL,
db_key STRING(32) NOT NULL,
matnr STRING(40),
stcts STRING(10),
datab DATE,
datbi_dateformat DATE,
ccngn STRING(30),
tclrm STRING(500),
crea_date_time NUMERIC(21,7),
crea_uname STRING(12),
lchg_date_time NUMERIC(21,7),
lchg_uname STRING(12),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
datbi STRING(10),
PRIMARY KEY (mandt, db_key) NOT ENFORCED
);