CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_wawi_precore_t038_itemfamily_2_product_to_product_group__ (
prod_sid INTEGER,
prod_grp_sid INTEGER,
prod_grp_type_cd STRING(20),
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
dwh_valid_fg BOOL,
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