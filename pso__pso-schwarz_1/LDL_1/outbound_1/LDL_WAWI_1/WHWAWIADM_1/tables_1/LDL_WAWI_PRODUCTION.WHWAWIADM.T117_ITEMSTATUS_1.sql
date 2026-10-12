CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.t117_itemstatus_1 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c117_itemno STRING(18) NOT NULL,
c117_warehouseno INTEGER NOT NULL,
c117_status INTEGER NOT NULL,
c117_updatedby STRING(8) NOT NULL,
c117_updatedon DATETIME NOT NULL,
c117_reason STRING(254),
c117_first_sale_date DATETIME,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c117_itemno, c117_warehouseno, wh_nr) NOT ENFORCED
);