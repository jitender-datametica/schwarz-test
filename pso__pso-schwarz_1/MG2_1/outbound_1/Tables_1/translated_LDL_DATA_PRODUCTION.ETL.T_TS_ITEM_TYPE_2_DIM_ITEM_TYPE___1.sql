CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_item_type_2_dim_item_type___1 (
item_type_cd STRING(20),
item_type_descr STRING(250),
item_type_descr_de STRING(250),
item_type_descr_en STRING(250),
dwh_load_id BIGNUMERIC(38,0),
dwh_node_cd STRING(20),
record_id STRING(1000),
deleted_fg BOOL,
error_descr STRING(1000),
filename STRING(1000),
hist_row_no STRING(1000),
dwh_mapping_tmsp TIMESTAMP,
error_fg BIGNUMERIC(38,0)
);