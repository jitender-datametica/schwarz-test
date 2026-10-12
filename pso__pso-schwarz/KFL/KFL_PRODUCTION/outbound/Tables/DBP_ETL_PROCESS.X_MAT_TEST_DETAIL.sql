CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.x_mat_test_detail (
test_id BIGNUMERIC(38,0),
kjwo BIGNUMERIC(38,0),
mandant_id BIGNUMERIC(38,0),
key_name STRING(100),
key_value BIGNUMERIC(38,0),
check_field_name STRING(100),
check_field_value STRING(300),
exp_value STRING(300),
run_cnt BIGNUMERIC(38,0),
date_load DATE,
time_load TIME
);