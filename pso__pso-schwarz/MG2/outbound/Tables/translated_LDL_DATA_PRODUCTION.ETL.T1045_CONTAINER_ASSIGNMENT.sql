CREATE OR REPLACE TABLE ldl_data_production_etl.t1045_container_assignment (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c1045_container_id INTEGER NOT NULL,
c1045_location_no INTEGER NOT NULL,
c1045_valid_from DATETIME NOT NULL,
c1045_valid_until DATETIME NOT NULL,
c1045_moduser STRING(50),
c1045_moddate DATETIME,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c1045_container_id, c1045_location_no, c1045_valid_from) NOT ENFORCED
);