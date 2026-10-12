CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_planned_value_type_2_planned_value_type___2 (
planned_val_type_sid INTEGER,
lang_cd STRING(2),
planned_val_type_descr STRING(250),
planned_val_type_id INTEGER,
planned_val_role_cd STRING(20),
dwh_load_id INTEGER,
dwh_node_cd STRING(20),
planning_process_cd STRING(20),
record_id STRING(1000),
deleted_fg BOOL,
error_descr STRING(1000),
filename STRING(1000),
hist_row_no STRING(1000),
dwh_mapping_tmsp TIMESTAMP,
dwh_ending_tmsp TIMESTAMP,
error_fg INTEGER
);