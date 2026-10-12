CREATE OR REPLACE TABLE ldl_data_production_etl.t029_wawi_item_ean (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
seqid INTEGER NOT NULL,
posno INTEGER,
itemno INTEGER NOT NULL,
ean INTEGER NOT NULL,
eandesc STRING(240),
location STRING(6),
transferdate DATETIME,
transferflag INTEGER NOT NULL,
action_flag INTEGER,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (ean, itemno, seqid) NOT ENFORCED
);