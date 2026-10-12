CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.bestandartikel (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
datum DATETIME NOT NULL,
artikelnr STRING(18) NOT NULL,
moving_stock BIGNUMERIC(30,10) NOT NULL,
menge BIGNUMERIC(30,10) NOT NULL,
retail_price BIGNUMERIC(30,10),
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (datum, artikelnr) NOT ENFORCED
);