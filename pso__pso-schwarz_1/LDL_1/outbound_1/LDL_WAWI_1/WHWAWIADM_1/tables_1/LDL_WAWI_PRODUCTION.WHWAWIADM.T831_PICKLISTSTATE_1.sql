CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.t831_pickliststate_1 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c831_picklistno INTEGER NOT NULL,
c831_orderarea STRING(8) NOT NULL,
c831_keycode INTEGER NOT NULL,
c831_storeno INTEGER NOT NULL,
c831_formdate DATETIME NOT NULL,
c831_moddate DATETIME,
c831_moduser STRING(8),
c831_oldkeycode INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c831_picklistno, c831_orderarea, wh_nr) NOT ENFORCED
);