CREATE OR REPLACE TABLE ldl_data_production_etl.t_tf_logistic_variant_type_2_dim_logistic_variant_type___1 (
logistic_variant_type_cd STRING(20) NOT NULL,
logistic_variant_type_descr STRING(250) NOT NULL,
logistic_variant_type_descr_de STRING(250),
logistic_variant_type_descr_en STRING(250),
dwh_node_cd STRING(20) NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300),
dwh_load_id INTEGER,
filename STRING(1000) NOT NULL,
error_descr STRING(1000)
);