CREATE OR REPLACE TABLE szd_production_etl.t_ts_cache_cds_item_2_customs_clearance_report_line_document_rel_int (
movement_ref_number STRING(250),
trader_reference STRING(250),
item_position INTEGER,
resource_item_sid INTEGER,
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