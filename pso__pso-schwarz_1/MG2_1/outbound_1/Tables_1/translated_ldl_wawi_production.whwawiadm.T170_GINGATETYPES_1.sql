CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.t170_gingatetypes_1 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c170_gatetypeid INTEGER NOT NULL,
c170_gatetype STRING(33) NOT NULL,
c170_show_pallets INTEGER,
c170_check_temp INTEGER,
c170_mult_bb_date INTEGER,
c170_mult_pal_fact INTEGER,
c170_def_task_type INTEGER,
c170_rcv_lane INTEGER NOT NULL,
scn INTEGER DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c170_gatetypeid, wh_nr) NOT ENFORCED
);