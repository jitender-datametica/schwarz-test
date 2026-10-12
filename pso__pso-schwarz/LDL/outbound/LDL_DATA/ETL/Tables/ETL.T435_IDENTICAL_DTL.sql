CREATE TABLE IF NOT EXISTS ldl_data_etl.t435_identical_dtl (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr BIGNUMERIC(38,0) NOT NULL,
c435_id INTEGER NOT NULL,
c435_itemnr STRING(14) NOT NULL,
c435_itemgroup INTEGER,
c435_retailprice BIGNUMERIC(30,10),
c435_itemdesc STRING(100),
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c435_id, c435_itemnr) NOT ENFORCED
);