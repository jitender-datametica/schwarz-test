CREATE OR REPLACE TABLE ldl_data_production_etl.t435_identical_dtl_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c435_id INTEGER NOT NULL,
c435_itemnr STRING(14) NOT NULL,
c435_itemgroup INTEGER,
c435_retailprice BIGNUMERIC(29,10),
c435_itemdesc STRING(100),
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c435_id, c435_itemnr) NOT ENFORCED
);