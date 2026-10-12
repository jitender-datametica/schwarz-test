CREATE OR REPLACE TABLE ldl_data_production_etl.bestandartikel_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
datum DATETIME NOT NULL,
artikelnr STRING(18) NOT NULL,
retail_price BIGNUMERIC(29,10),
dummy_2 STRING(254),
menge BIGNUMERIC(29,10) NOT NULL,
moving_stock BIGNUMERIC(29,10) NOT NULL,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (datum, artikelnr) NOT ENFORCED
);