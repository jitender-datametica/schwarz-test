CREATE OR REPLACE TABLE ldl_data_production_etl.t_tf_listing_type_2_dim_listing_type___2 (
list_type_cd STRING(20) NOT NULL,
list_type_descr STRING(250) NOT NULL,
list_type_descr_de STRING(250),
list_type_descr_en STRING(250),
dwh_node_cd STRING(20) NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300),
dwh_load_id INTEGER,
filename STRING(1000) NOT NULL,
error_descr STRING(1000)
);