CREATE TABLE IF NOT EXISTS ldl_data_etl.bestandartikel_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr BIGNUMERIC(38,0) NOT NULL,
datum DATETIME NOT NULL,
artikelnr STRING(18) NOT NULL,
retail_price BIGNUMERIC(30,10),
dummy_1 STRING(254),
menge BIGNUMERIC(30,10) NOT NULL,
moving_stock BIGNUMERIC(30,10) NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (datum, artikelnr) NOT ENFORCED
);