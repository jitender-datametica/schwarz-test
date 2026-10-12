CREATE OR REPLACE TABLE szd_production_etl.t_ts_cache_ceva_2_customs_procedure_int_1 (
customs_procedure_cd STRING(50),
requested_procedure_cd STRING(50),
additional_procedure_cd STRING(50),
approved_fg BOOL,
dwh_src_file_name STRING(500),
dwh_src_1_tmsp TIMESTAMP,
record_id STRING(1000),
deleted_fg BOOL,
error_descr STRING(1000),
filename STRING(1000),
hist_row_no STRING(1000),
dwh_mapping_tmsp TIMESTAMP,
dwh_ending_tmsp TIMESTAMP,
error_fg INTEGER,
dwh_load_id INTEGER
);