CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.t119_status_locked (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c119_itemno STRING(18) NOT NULL,
c119_warehouseno INTEGER NOT NULL,
c119_locked INTEGER NOT NULL,
c119_moduser STRING(8) NOT NULL,
c119_moddate DATETIME,
scn INTEGER DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c119_itemno, c119_warehouseno, wh_nr) NOT ENFORCED
);