CREATE OR REPLACE TABLE ldl_data_production_etl.t119_status_locked (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c119_itemno STRING(18) NOT NULL,
c119_warehouseno INTEGER NOT NULL,
c119_locked INTEGER NOT NULL,
c119_moduser STRING(8) NOT NULL,
c119_moddate DATETIME,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c119_itemno, c119_warehouseno) NOT ENFORCED
);