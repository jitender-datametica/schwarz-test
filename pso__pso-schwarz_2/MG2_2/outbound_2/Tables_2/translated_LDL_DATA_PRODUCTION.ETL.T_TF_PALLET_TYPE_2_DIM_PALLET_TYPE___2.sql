CREATE OR REPLACE TABLE ldl_data_production_etl.t_tf_pallet_type_2_dim_pallet_type___2 (
pallet_type_cd STRING(20) NOT NULL,
pallet_type_descr STRING(250) NOT NULL,
pallet_type_descr_de STRING(250),
pallet_type_descr_en STRING(250),
pallet_space_factor NUMERIC(29,5),
dwh_node_cd STRING(20) NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300),
dwh_load_id INTEGER,
filename STRING(1000) NOT NULL,
error_descr STRING(1000)
);