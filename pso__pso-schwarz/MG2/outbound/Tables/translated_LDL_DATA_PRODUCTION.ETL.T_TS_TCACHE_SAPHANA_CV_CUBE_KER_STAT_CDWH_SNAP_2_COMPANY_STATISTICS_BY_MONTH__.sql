CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_tcache_saphana_cv_cube_ker_stat_cdwh_snap_2_company_statistics_by_month__
(
int_company_sid BIGNUMERIC(38,0),
stat_type_cd STRING(20),
stat_dt DATE,
cal_month BIGNUMERIC(38,0),
curr_stat_fg BOOL,
stat_val BIGNUMERIC(38,5),
curr_cd STRING(3),
stat_cnt BIGNUMERIC(38,0),
stat_qty BIGNUMERIC(38,5),
stat_meas BIGNUMERIC(38,5),
uom_cd STRING(20),
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