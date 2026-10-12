CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_dispatch_group_2_dim_dispatch_group___2 (
dispatch_grp_nr STRING(20),
country_org_sid BIGNUMERIC(38,0),
dispatch_grp_descr STRING(250),
dispatch_grp_descr_de STRING(250),
dispatch_grp_descr_en STRING(250),
dwh_load_id BIGNUMERIC(38,0),
dwh_node_cd STRING(20),
record_id STRING(1000),
deleted_fg BOOL,
error_descr STRING(1000),
filename STRING(1000),
hist_row_no STRING(1000),
dwh_mapping_tmsp TIMESTAMP,
dwh_ending_tmsp TIMESTAMP,
error_fg BIGNUMERIC(38,0)
);