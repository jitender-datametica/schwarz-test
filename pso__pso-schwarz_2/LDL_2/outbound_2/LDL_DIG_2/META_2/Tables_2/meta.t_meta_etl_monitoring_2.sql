CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_meta_etl_monitoring_2 (
solution_name STRING(100),
table_name STRING(100),
test_case_id STRING(100),
test_case_desc STRING(100),
test_case_status BIGNUMERIC(38,0),
execution_date DATETIME,
test_case_long_desc STRING(1000)
);