DROP TABLE IF EXISTS ldl_wawi_production_whwawiadm.bestandartikel_2;
CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.bestandartikel_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
datum DATETIME NOT NULL,
artikelnr STRING(18) NOT NULL,
retail_price BIGNUMERIC(30,10),
menge BIGNUMERIC(30,10) NOT NULL,
moving_stock BIGNUMERIC(30,10) NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (datum, artikelnr, wh_nr) NOT ENFORCED
) CLUSTER BY datum;