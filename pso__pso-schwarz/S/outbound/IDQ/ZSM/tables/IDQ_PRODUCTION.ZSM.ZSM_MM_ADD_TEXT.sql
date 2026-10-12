CREATE OR REPLACE TABLE idq_production_zsm.zsm_mm_add_text (
mandt STRING(3),
matnr STRING(18) NOT NULL,
txtyp STRING(1) NOT NULL,
text STRING(40),
ernam STRING(12),
erdat DATE,
aenam STRING(12),
aedat DATE,
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (matnr, txtyp) NOT ENFORCED
);