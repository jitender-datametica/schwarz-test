CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_tcache_saphana_cv_cube_ker_values_cdwh_snap_2_plan_by_country_month___2
(
reporting_country_cd STRING(20),
cal_month BIGNUMERIC(38,0),
planned_val_type_sid BIGNUMERIC(38,0),
plan_pos_nr STRING(20),
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
dwh_valid_fg BOOL,
planned_kpi_meas BIGNUMERIC(38,5),
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