CREATE OR REPLACE TABLE ldl_data_production_etl.t_tf_order_area_2_dim_order_area__ (
order_area_nr STRING(20) NOT NULL,
country_org_sid INTEGER NOT NULL,
country_org_cd STRING(2),
order_area_descr STRING(250) NOT NULL,
order_area_descr_de STRING(250),
order_area_descr_en STRING(250),
dwh_node_cd STRING(20) NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300),
dwh_load_id INTEGER,
filename STRING(1000) NOT NULL,
error_descr STRING(1000)
);