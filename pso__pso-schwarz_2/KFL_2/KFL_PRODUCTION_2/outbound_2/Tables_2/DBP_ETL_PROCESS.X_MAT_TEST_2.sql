CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.x_mat_test_2 (
test_id BIGNUMERIC(38,0),
test_type STRING(20),
kjwo BIGNUMERIC(38,0),
test_status STRING(10),
error_count BIGNUMERIC(38,0),
error_mandant_id STRING(100),
run_cnt BIGNUMERIC(38,0),
date_load DATE,
time_load TIME
);