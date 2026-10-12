CREATE OR REPLACE TABLE idq_production_sp_mep.equk (
mandt STRING(3) NOT NULL,
matnr STRING(18) NOT NULL,
werks STRING(4) NOT NULL,
bdatu DATE NOT NULL,
vdatu DATE,
qunum STRING(10),
erdat DATE,
ernam STRING(12),
scmng NUMERIC(15,3),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, matnr, werks, bdatu) NOT ENFORCED
);