CREATE TABLE IF NOT EXISTS idq_production_sp_mep.mast (
mandt STRING(3) NOT NULL,
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
PRIMARY KEY (mandt, matnr, werks, stlan, stlnr, stlal) NOT ENFORCED
);