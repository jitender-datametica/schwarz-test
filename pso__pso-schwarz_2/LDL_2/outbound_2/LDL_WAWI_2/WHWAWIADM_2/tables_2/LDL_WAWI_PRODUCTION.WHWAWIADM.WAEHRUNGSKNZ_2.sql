CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.waehrungsknz_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
waehrungsknz_2 INTEGER NOT NULL,
waehrkbez STRING(3) NOT NULL,
waehrbez STRING(28),
gueltig_ab DATETIME,
standard_ue NUMERIC(6,2),
datum DATETIME,
bediener STRING(8),
currencysign1 STRING(3),
currencysign2 STRING(3),
toleranz BIGNUMERIC(30,10),
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (waehrungsknz_2, wh_nr) NOT ENFORCED
);