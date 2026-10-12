CREATE OR REPLACE TABLE ldl_data_production_etl.t_tf_brand_2_dim_brand___2 (
brand_name STRING(200) NOT NULL,
dwh_node_cd STRING(20) NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300),
dwh_load_id INTEGER,
filename STRING(1000) NOT NULL,
error_descr STRING(1000)
);