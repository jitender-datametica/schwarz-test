CREATE OR REPLACE TABLE ldl_data_production_etl.t_tf_inventory_reason_2_dim_inventory_reason___2 (
inv_reason_id INTEGER NOT NULL,
inv_reason_descr STRING(250) NOT NULL,
inv_reason_descr_de STRING(250),
inv_reason_descr_en STRING(250),
dwh_node_cd STRING(20) NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300),
dwh_load_id INTEGER,
filename STRING(1000) NOT NULL,
error_descr STRING(1000)
);