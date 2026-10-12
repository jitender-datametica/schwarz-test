CREATE OR REPLACE TABLE idq_production_kfl_ret.zek_nf_main_2 (
mandt STRING(3) NOT NULL,
matnr STRING(40) NOT NULL,
unit_2 STRING(19) NOT NULL,
id_base STRING(7) NOT NULL,
id_nf STRING(7) NOT NULL,
value STRING(10),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, matnr, unit_2, id_base, id_nf) NOT ENFORCED
);