CREATE OR REPLACE TABLE ldl_data_production_etl.t_tf_unit_of_measure_2_dim_unit_of_measure___2 (
uom_cd STRING(20) NOT NULL,
uom_name STRING(250) NOT NULL,
uom_name_de STRING(250),
uom_name_en STRING(250),
dwh_node_cd STRING(20) NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300),
dwh_load_id INTEGER,
filename STRING(1000) NOT NULL,
error_descr STRING(1000)
);