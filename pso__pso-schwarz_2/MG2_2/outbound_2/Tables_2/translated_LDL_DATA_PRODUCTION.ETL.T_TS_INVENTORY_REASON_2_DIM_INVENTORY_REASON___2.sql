CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_inventory_reason_2_dim_inventory_reason___2 (
inv_reason_id INTEGER,
inv_reason_descr STRING(250),
inv_reason_descr_de STRING(250),
inv_reason_descr_en STRING(250),
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