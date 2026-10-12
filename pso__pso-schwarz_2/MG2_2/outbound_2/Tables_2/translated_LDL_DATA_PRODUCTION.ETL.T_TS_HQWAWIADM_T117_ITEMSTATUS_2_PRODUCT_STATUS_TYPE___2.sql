CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_hqwawiadm_t117_itemstatus_2_product_status_type___2 (
prod_status_categ_cd STRING(20),
prod_status_type_cd STRING(20),
lang_cd STRING(2),
prod_status_type_descr STRING(250),
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