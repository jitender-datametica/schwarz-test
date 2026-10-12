CREATE TABLE IF NOT EXISTS ldl_data_etl.t119_status_locked_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr BIGNUMERIC(38,0) NOT NULL,
c119_itemno STRING(18) NOT NULL,
c119_warehouseno INTEGER NOT NULL,
c119_locked INTEGER NOT NULL,
c119_moduser STRING(8) NOT NULL,
c119_moddate DATETIME,
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c119_itemno, c119_warehouseno) NOT ENFORCED
);