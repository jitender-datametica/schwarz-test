CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.mat_test_desc (
test_id BIGNUMERIC(38,0),
kjwo BIGNUMERIC(38,0),
check_field_name STRING(100),
description STRING(500),
run_cnt BIGNUMERIC(38,0),
date_load DATE,
time_load TIME
);