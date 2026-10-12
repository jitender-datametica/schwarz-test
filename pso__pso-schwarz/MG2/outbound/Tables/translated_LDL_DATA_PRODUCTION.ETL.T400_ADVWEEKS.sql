CREATE OR REPLACE TABLE ldl_data_production_etl.t400_advweeks (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c400_id INTEGER NOT NULL,
c400_advdate DATETIME,
c400_date_a DATETIME,
c400_date_b DATETIME,
c400_date_x DATETIME,
c400_moddate DATETIME,
c400_moduser STRING(8),
c400_advweek STRING(15),
scn INTEGER DEFAULT 0,
c400_auto INTEGER,
extraction_tmsp DATETIME,
PRIMARY KEY (c400_id) NOT ENFORCED
);