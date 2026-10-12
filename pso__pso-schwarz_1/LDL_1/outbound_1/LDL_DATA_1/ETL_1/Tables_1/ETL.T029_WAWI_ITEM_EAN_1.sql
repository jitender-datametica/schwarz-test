CREATE TABLE IF NOT EXISTS ldl_data_etl.t029_wawi_item_ean_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
seqid INTEGER NOT NULL,
posno INTEGER,
itemno INTEGER NOT NULL,
ean_1 INTEGER NOT NULL,
eandesc STRING(240),
location_1 STRING(6),
transferdate DATETIME,
transferflag INTEGER NOT NULL,
action_flag INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (ean_1, itemno, seqid) NOT ENFORCED
);