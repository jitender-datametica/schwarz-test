CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t024_wawi_item_dep_1 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
seqid INTEGER NOT NULL,
itemno_head INTEGER NOT NULL,
itemno_detail INTEGER NOT NULL,
posno INTEGER NOT NULL,
quantity INTEGER,
transferdate DATETIME,
transferflag INTEGER NOT NULL,
action_flag INTEGER,
location_1 STRING(6) NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (seqid, itemno_head, itemno_detail) NOT ENFORCED
);