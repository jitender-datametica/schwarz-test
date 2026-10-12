CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_tcache_kpges_ref_indicator_2_planned_value_type___2 (
planned_val_type_sid BIGNUMERIC(38,0),
lang_cd STRING(2),
planned_val_type_descr STRING(250),
planned_val_type_id BIGNUMERIC(38,0),
planned_val_role_cd STRING(20),
dwh_load_id BIGNUMERIC(38,0),
dwh_node_cd STRING(20),
record_id STRING(1000),
deleted_fg BOOL,
error_descr STRING(1000),
filename STRING(1000),
hist_row_no STRING(1000),
dwh_mapping_tmsp TIMESTAMP,
error_fg BIGNUMERIC(38,0)
);