CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_t118_statusdesc_2_wawi_precore_t118_statusdesc___1 (
ctrcode STRING(3) COLLATE 'und:ci',
extraction_tmsp DATETIME,
status_1 INTEGER,
statusdesc STRING(50),
hq INTEGER,
wh INTEGER,
scn INTEGER,
dwh_load_id INTEGER,
record_id STRING(1000),
deleted_fg BOOL,
error_descr STRING(1000),
filename STRING(1000),
hist_row_no STRING(1000),
dwh_mapping_tmsp TIMESTAMP,
dwh_ending_tmsp TIMESTAMP,
error_fg INTEGER
);