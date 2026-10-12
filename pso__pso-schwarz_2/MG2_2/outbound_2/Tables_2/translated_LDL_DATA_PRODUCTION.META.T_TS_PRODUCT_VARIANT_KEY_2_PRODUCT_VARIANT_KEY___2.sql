CREATE OR REPLACE TABLE ldl_data_production_meta.t_ts_product_variant_key_2_product_variant_key___2 (
prod_variant_sid INTEGER,
prod_variant_key_type_cd STRING(20),
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
dwh_valid_fg BOOL,
prod_variant_nat_key_nr STRING(250),
dwh_load_id INTEGER,
dwh_node_cd STRING(20),
record_id STRING(1000),
deleted_fg BOOL,
error_descr STRING(1000),
filename STRING(1000),
hist_row_no STRING(1000),
dwh_mapping_tmsp TIMESTAMP,
error_fg INTEGER
);