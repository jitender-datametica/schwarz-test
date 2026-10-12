CREATE TABLE IF NOT EXISTS ldl_data_etl.wawi_extract_t043_intitemgrp_log_temp_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr STRING(5),
table_name STRING(16777216),
max_scn BIGNUMERIC(38,0),
created_tmsp DATETIME,
updated_tmsp DATETIME
);