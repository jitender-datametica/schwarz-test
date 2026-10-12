CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.dispoeinheit_1 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
disponr INTEGER NOT NULL,
dispoeinheit_1 STRING(35) NOT NULL,
datum DATETIME,
bediener STRING(8),
sql_beziehung STRING(18),
shortdesc STRING(10) NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (disponr, wh_nr) NOT ENFORCED
);