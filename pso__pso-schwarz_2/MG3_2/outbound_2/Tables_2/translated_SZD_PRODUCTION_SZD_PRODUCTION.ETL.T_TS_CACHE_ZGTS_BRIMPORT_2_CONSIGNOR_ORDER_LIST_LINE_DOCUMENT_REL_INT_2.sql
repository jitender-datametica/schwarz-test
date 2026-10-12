CREATE OR REPLACE TABLE szd_production_etl.t_ts_cache_zgts_brimport_2_consignor_order_list_line_document_rel_int_2 (
trader_reference_nr STRING(250),
order_dt DATE,
item_position_seq INTEGER,
resource_item_sid INTEGER,
preference_indicator_fg BOOL,
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