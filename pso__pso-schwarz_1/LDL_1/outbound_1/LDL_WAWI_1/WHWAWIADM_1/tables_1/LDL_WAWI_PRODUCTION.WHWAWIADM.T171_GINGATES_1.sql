CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.t171_gingates_1 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c171_gingate INTEGER NOT NULL,
c171_gatetypeid INTEGER NOT NULL,
c171_usecount INTEGER NOT NULL,
c171_status INTEGER,
c171_stplace_from INTEGER,
c171_stplace_until INTEGER,
c171_label_printer INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c171_gingate, wh_nr) NOT ENFORCED
);