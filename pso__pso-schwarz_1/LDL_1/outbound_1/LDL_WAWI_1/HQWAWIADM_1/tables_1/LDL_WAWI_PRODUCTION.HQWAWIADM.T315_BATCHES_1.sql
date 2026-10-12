CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t315_batches_1 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c315_batchid INTEGER NOT NULL,
c315_state INTEGER NOT NULL,
c315_moddate DATETIME,
c315_moduser STRING(8),
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c315_batchid) NOT ENFORCED
);