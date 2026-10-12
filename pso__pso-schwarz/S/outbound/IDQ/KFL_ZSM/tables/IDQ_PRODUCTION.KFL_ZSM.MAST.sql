CREATE OR REPLACE TABLE idq_production_kfl_zsm.mast (
mandt STRING(3) NOT NULL,
matnr STRING(40) NOT NULL,
werks STRING(4) NOT NULL,
stlan STRING(1) NOT NULL,
stlnr STRING(8) NOT NULL,
stlal STRING(2) NOT NULL,
losvn NUMERIC(14,3),
losbs NUMERIC(14,3),
andat DATE,
annam STRING(12),
aedat DATE,
aenam STRING(12),
cslty STRING(1),
material_bom_key STRING(90),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, matnr, stlal, stlan, stlnr, werks) NOT ENFORCED
);