CREATE OR REPLACE TABLE ldl_data_production_etl.t436_countinglist_head_wh_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c436_list_id INTEGER NOT NULL,
c436_filename STRING(50) NOT NULL,
c436_importdate DATETIME NOT NULL,
c436_moduser STRING(8),
c436_moddate DATETIME,
c436_type INTEGER,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c436_list_id) NOT ENFORCED
);