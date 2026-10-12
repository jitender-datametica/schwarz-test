CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_tcache_cbx_cnt_item_2_product_internal_organization_status__ (
prod_sid INTEGER,
int_org_sid INTEGER,
prod_status_categ_cd STRING(20),
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
dwh_valid_fg BOOL,
prod_status_type_cd STRING(20),
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