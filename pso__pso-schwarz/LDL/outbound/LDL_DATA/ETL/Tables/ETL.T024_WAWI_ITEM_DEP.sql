CREATE TABLE IF NOT EXISTS ldl_data_etl.t024_wawi_item_dep (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
seqid INTEGER NOT NULL,
itemno_head INTEGER NOT NULL,
itemno_detail INTEGER NOT NULL,
posno INTEGER NOT NULL,
quantity INTEGER,
transferdate DATETIME,
transferflag INTEGER NOT NULL,
action_flag INTEGER,
location STRING(6) NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (seqid, itemno_head, itemno_detail) NOT ENFORCED
);