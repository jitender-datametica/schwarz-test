CREATE OR REPLACE TABLE ldl_data_production_etl.t024_wawi_item_dep_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
seqid INTEGER NOT NULL,
itemno_head INTEGER NOT NULL,
itemno_detail INTEGER NOT NULL,
posno INTEGER NOT NULL,
quantity INTEGER,
transferdate DATETIME,
transferflag INTEGER NOT NULL,
action_flag INTEGER,
location_1 STRING(6) NOT NULL,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (seqid, itemno_head, itemno_detail) NOT ENFORCED
);