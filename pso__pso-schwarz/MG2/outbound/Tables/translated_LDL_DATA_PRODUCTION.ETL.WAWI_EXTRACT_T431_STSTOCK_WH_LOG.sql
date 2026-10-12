CREATE OR REPLACE TABLE ldl_data_production_etl.wawi_extract_t431_ststock_wh_log (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr STRING(5),
table_name STRING(16777216),
max_scn INTEGER,
created_tmsp DATETIME,
updated_tmsp DATETIME
);