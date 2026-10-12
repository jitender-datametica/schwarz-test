CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.t1356_xwh_stock (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c1356_dayenddate DATETIME NOT NULL,
c1356_whnum INTEGER,
c1356_itemnr STRING(18),
c1356_mhddate DATETIME,
c1356_cases INTEGER,
c1356_pallets INTEGER,
c1356_slotnr INTEGER,
c1356_groupnr INTEGER,
c1356_artgroupnr INTEGER,
c1356_idvalue BIGNUMERIC(38,10) NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
c1356_pmat STRING(4) NOT NULL,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c1356_idvalue, wh_nr) NOT ENFORCED
);