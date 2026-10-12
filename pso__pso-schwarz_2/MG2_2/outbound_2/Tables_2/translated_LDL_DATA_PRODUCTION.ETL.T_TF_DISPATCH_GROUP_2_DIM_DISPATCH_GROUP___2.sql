CREATE OR REPLACE TABLE ldl_data_production_etl.t_tf_dispatch_group_2_dim_dispatch_group___2 (
dispatch_grp_nr STRING(20) NOT NULL,
country_org_sid INTEGER NOT NULL,
dispatch_grp_descr STRING(250) NOT NULL,
dispatch_grp_descr_de STRING(250),
dispatch_grp_descr_en STRING(250),
dwh_node_cd STRING(20) NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300),
dwh_load_id INTEGER,
filename STRING(1000) NOT NULL,
error_descr STRING(1000)
);