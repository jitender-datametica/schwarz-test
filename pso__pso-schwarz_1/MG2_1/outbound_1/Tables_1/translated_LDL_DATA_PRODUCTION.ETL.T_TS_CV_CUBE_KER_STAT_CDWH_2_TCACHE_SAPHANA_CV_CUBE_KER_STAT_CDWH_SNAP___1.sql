CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_cv_cube_ker_stat_cdwh_2_tcache_saphana_cv_cube_ker_stat_cdwh_snap___1
(
extraction_ts DATETIME,
extraction_date DATE,
source_system STRING(100000),
bic_zmlila STRING(100000),
calmonth STRING(100000),
load_id FLOAT64,
gxxmlklag STRING(100000),
vlxmlcntr STRING(100000),
unit_1 STRING(100000),
ist FLOAT64,
plan FLOAT64,
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