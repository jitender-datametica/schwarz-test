CREATE OR REPLACE TABLE idq_production_zsm.mast_1 (
mandt STRING(3),
matnr STRING(18) NOT NULL,
werks STRING(4) NOT NULL,
stlan STRING(1) NOT NULL,
stlnr STRING(8) NOT NULL,
stlal STRING(2) NOT NULL,
losvn NUMERIC(13,3),
losbs NUMERIC(13,3),
andat DATE,
annam STRING(12),
aedat DATE,
aenam STRING(12),
cslty STRING(1),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (matnr, werks, stlan, stlnr, stlal) NOT ENFORCED
);