CREATE OR REPLACE TABLE ldl_wawi_production_wawiadm.waehrungsknz_1 (
waehrungsknz_1 INTEGER NOT NULL,
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
PRIMARY KEY (waehrungsknz_1) NOT ENFORCED
);