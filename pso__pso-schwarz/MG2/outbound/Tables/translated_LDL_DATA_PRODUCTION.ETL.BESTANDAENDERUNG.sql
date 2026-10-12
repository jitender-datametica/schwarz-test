CREATE OR REPLACE TABLE ldl_data_production_etl.bestandaenderung (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
artikelnr STRING(18) NOT NULL,
datum DATETIME NOT NULL,
vkpnorm BIGNUMERIC(29,10),
type STRING(1) NOT NULL,
inventorynum INTEGER NOT NULL,
menge BIGNUMERIC(29,10) NOT NULL,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (artikelnr, datum, inventorynum, type) NOT ENFORCED
);