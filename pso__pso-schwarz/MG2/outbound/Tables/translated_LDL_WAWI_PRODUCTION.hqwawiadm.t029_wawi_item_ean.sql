CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t029_wawi_item_ean (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
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
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (itemno, ean, seqid) NOT ENFORCED
);