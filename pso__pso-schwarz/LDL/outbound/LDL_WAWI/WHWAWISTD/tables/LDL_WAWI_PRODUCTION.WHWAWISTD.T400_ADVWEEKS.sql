CREATE OR REPLACE TABLE ldl_wawi_production_whwawistd.t400_advweeks (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c400_id INTEGER NOT NULL,
c400_advdate DATETIME,
c400_date_a DATETIME,
c400_date_b DATETIME,
c400_date_x DATETIME,
c400_moddate DATETIME,
c400_moduser STRING(8),
c400_advweek STRING(15),
scn BIGNUMERIC(38,0) DEFAULT 0,
c400_auto INTEGER,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c400_id, wh_nr) NOT ENFORCED
);