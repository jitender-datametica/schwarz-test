CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.t215_int_itemnr_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c215_int_itemnr STRING(20) NOT NULL,
c215_itemnr STRING(18) NOT NULL,
c215_int_itemdesc STRING(100),
c215_casesize NUMERIC(10,5),
c215_moddate DATETIME,
c215_moduser STRING(8),
c215_int_itemnrsho STRING(4),
c215_active INTEGER,
c215_is_main_link INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c215_int_itemnr, c215_itemnr, wh_nr) NOT ENFORCED
);