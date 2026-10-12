CREATE TABLE IF NOT EXISTS ldl_data_etl.t117_itemstatus (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr BIGNUMERIC(38,0) NOT NULL,
c117_itemno STRING(18) NOT NULL,
c117_warehouseno INTEGER NOT NULL,
c117_status INTEGER NOT NULL,
c117_updatedby STRING(8) NOT NULL,
c117_updatedon DATETIME,
c117_reason STRING(254),
c117_first_sale_date DATETIME,
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c117_itemno, c117_warehouseno) NOT ENFORCED
);