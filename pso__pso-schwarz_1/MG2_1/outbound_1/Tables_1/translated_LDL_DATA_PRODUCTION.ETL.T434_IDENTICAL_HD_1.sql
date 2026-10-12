CREATE OR REPLACE TABLE ldl_data_production_etl.t434_identical_hd_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c434_id INTEGER NOT NULL,
c434_moddate DATETIME,
c434_moduser STRING(8),
c434_description STRING(40),
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c434_id) NOT ENFORCED
);