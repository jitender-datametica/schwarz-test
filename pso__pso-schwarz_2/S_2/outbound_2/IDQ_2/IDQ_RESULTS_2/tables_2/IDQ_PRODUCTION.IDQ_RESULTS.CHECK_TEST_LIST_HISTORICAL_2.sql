CREATE OR REPLACE TABLE idq_production_idq_results.check_test_list_historical_2 (
date_of_test_run DATETIME,
test_object_id BIGNUMERIC(38,0),
rule_id BIGNUMERIC(38,0),
is_error_detected BIGNUMERIC(38,0),
test_run_day_id BIGNUMERIC(38,0)
);