CREATE TABLE IF NOT EXISTS ldl_data_etl.waehrungsknz_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
waehrungsknz_1 INTEGER NOT NULL,
waehrkbez STRING(3) NOT NULL,
waehrbez STRING(28),
gueltig_ab DATETIME,
standard_ue NUMERIC(6,2),
datum DATETIME,
bediener STRING(8),
toleranz BIGNUMERIC(30,10),
currencysign1 STRING(3),
currencysign2 STRING(3),
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (waehrungsknz_1) NOT ENFORCED
);