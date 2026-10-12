CREATE OR REPLACE TABLE szd_production_etl.t_ts_cache_sventitaet_2_export_warehouse_int_1 (
resource_item_sid INTEGER,
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
dwh_valid_fg BOOL,
export_warehouse_name STRING(100),
dwh_src_file_name STRING(500),
dwh_src_1_tmsp TIMESTAMP,
record_id STRING(1000),
deleted_fg BOOL,
error_descr STRING(1000),
filename STRING(1000),
hist_row_no STRING(1000),
dwh_mapping_tmsp TIMESTAMP,
dwh_ending_tmsp TIMESTAMP,
error_fg INTEGER,
dwh_load_id INTEGER
);