CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t118_statusdesc (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c118_status INTEGER NOT NULL,
c118_statusdesc STRING(50),
c118_hq INTEGER,
c118_wh INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c118_status) NOT ENFORCED
);