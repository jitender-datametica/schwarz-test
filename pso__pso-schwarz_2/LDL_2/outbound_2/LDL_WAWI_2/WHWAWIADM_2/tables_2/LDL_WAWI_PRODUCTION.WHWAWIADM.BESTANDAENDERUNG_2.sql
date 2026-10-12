CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.bestandaenderung_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
artikelnr STRING(18) NOT NULL,
datum DATETIME NOT NULL,
vkpnorm BIGNUMERIC(30,10),
type STRING(1) NOT NULL,
inventorynum INTEGER NOT NULL,
menge BIGNUMERIC(30,10) NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (artikelnr, datum, inventorynum, type, wh_nr) NOT ENFORCED
);