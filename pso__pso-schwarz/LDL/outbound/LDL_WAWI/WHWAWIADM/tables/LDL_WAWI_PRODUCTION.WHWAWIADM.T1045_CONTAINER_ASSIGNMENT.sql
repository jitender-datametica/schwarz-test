CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.t1045_container_assignment (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c1045_container_id INTEGER NOT NULL,
c1045_location_no INTEGER NOT NULL,
c1045_valid_from DATETIME NOT NULL,
c1045_valid_until DATETIME NOT NULL,
c1045_moduser STRING(50),
c1045_moddate DATETIME,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c1045_container_id, c1045_location_no, c1045_valid_from, wh_nr) NOT ENFORCED
);