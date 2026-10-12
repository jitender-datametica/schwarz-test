CREATE OR REPLACE TABLE szd_production_etl.t_ts_cache_zgts_brimport_2_consignor_order_list_line_specification_int_1 (
trader_reference_nr STRING(250),
order_dt DATE,
item_position_seq INTEGER,
specification_seq INTEGER,
spec_uom_id INTEGER,
spec_meas NUMERIC(29,5),
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