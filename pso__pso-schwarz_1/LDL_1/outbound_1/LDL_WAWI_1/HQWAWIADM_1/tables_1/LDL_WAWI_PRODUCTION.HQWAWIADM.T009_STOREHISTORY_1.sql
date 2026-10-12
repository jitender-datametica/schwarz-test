CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t009_storehistory_1 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c009_storeno INTEGER NOT NULL,
c009_warehouseno INTEGER NOT NULL,
c009_datefrom DATETIME NOT NULL,
c009_dateuntil DATETIME NOT NULL,
c009_moduser STRING(8) NOT NULL,
c009_moddate DATETIME NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c009_storeno, c009_datefrom) NOT ENFORCED
);