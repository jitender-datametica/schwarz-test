CREATE OR REPLACE TABLE ldl_data_production_etl.t_tf_packing_type_2_dim_packing_type___1 (
packing_type_cd STRING(20) NOT NULL,
packing_type_descr STRING(250) NOT NULL,
packing_type_descr_de STRING(250),
packing_type_descr_en STRING(250),
dwh_node_cd STRING(20) NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300),
dwh_load_id INTEGER,
filename STRING(1000) NOT NULL,
error_descr STRING(1000)
);