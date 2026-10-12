CREATE OR REPLACE TABLE szd_production_etl.t_ts_cache_ceva_2_customs_tariff_code_int (
customs_classification_scheme_cd STRING(50),
customs_tariff_code_cd STRING(250),
customs_tariff_code_descr STRING(250),
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