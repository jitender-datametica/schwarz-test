CREATE OR REPLACE TABLE idq_production_kfl_ret.dmf_d_art (
application STRING(10) NOT NULL,
art_customer_il STRING(1),
art_hier_il STRING(1),
art_site_il STRING(1),
completed STRING(1),
deleted STRING(1),
init_load STRING(1),
mandt STRING(3) NOT NULL,
matnr STRING(40) NOT NULL,
rel STRING(1),
sos_il STRING(1),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (application, mandt, matnr) NOT ENFORCED
);