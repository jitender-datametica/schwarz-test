CREATE TABLE IF NOT EXISTS ldl_data_etl.bestandaenderung_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr BIGNUMERIC(38,0) NOT NULL,
artikelnr STRING(18) NOT NULL,
datum DATETIME NOT NULL,
vkpnorm BIGNUMERIC(30,10),
type STRING(1) NOT NULL,
inventorynum INTEGER NOT NULL,
menge BIGNUMERIC(30,10) NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (artikelnr, datum, inventorynum, type) NOT ENFORCED
);