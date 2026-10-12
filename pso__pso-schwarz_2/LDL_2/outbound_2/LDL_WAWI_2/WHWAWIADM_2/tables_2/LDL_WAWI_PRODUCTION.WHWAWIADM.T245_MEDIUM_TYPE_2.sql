CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.t245_medium_type_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c245_id INTEGER NOT NULL,
c245_type_id INTEGER NOT NULL,
c245_code STRING(25) NOT NULL,
c245_readonly INTEGER NOT NULL,
c245_moduser STRING(20) NOT NULL,
c245_moddate DATETIME NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c245_id, wh_nr) NOT ENFORCED
);