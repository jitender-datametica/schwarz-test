CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_whwawiadm_bestbereich_2_order_area___2 (
order_area_nr STRING(20),
int_org_sid INTEGER,
lang_cd STRING(2),
order_area_descr STRING(250),
dwh_load_id INTEGER,
dwh_node_cd STRING(20),
record_id STRING(1000),
deleted_fg BOOL,
error_descr STRING(1000),
filename STRING(1000),
hist_row_no STRING(1000),
dwh_mapping_tmsp TIMESTAMP,
dwh_ending_tmsp TIMESTAMP,
error_fg INTEGER
);