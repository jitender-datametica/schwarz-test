CREATE OR REPLACE TABLE ldl_data_production_etl.waehrungsknz_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
waehrungsknz_2 INTEGER NOT NULL,
waehrkbez STRING(3) NOT NULL,
waehrbez STRING(28),
gueltig_ab DATETIME,
standard_ue NUMERIC(6,2),
datum DATETIME,
bediener STRING(8),
toleranz BIGNUMERIC(29,10),
currencysign1 STRING(3),
currencysign2 STRING(3),
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (waehrungsknz_2) NOT ENFORCED
);