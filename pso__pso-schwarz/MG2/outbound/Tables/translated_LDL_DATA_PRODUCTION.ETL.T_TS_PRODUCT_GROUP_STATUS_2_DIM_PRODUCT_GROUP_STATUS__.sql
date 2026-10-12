CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_product_group_status_2_dim_product_group_status__ (
prod_grp_status_cd STRING(20),
prod_grp_status_descr STRING(250),
prod_grp_status_descr_de STRING(250),
prod_grp_status_descr_en STRING(250),
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