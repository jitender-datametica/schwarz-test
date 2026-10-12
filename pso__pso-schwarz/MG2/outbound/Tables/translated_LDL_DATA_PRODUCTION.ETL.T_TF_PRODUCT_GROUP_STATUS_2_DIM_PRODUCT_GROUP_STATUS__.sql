CREATE OR REPLACE TABLE ldl_data_production_etl.t_tf_product_group_status_2_dim_product_group_status__ (
prod_grp_status_cd STRING(20) NOT NULL,
prod_grp_status_descr STRING(250) NOT NULL,
prod_grp_status_descr_de STRING(250),
prod_grp_status_descr_en STRING(250),
dwh_node_cd STRING(20) NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300),
dwh_load_id INTEGER,
filename STRING(1000) NOT NULL,
error_descr STRING(1000)
);