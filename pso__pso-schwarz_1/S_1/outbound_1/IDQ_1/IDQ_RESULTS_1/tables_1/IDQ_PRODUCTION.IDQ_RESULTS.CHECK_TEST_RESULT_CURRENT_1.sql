DROP TABLE IF EXISTS idq_production_idq_results.check_test_result_current_1;
CREATE OR REPLACE TABLE idq_production_idq_results.check_test_result_current_1 (
scope_id BIGNUMERIC(38,0),
test_object_id BIGNUMERIC(38,0),
rule_id BIGNUMERIC(38,0),
is_error_detected BIGNUMERIC(38,0),
first_negative_test DATETIME,
first_negative_test_day_id BIGNUMERIC(38,0),
first_positive_test DATETIME,
first_positive_test_day_id BIGNUMERIC(38,0),
error_solved BIGNUMERIC(38,0),
due_date DATETIME,
due_day_id BIGNUMERIC(38,0),
flip_count BIGNUMERIC(38,0)
) CLUSTER BY is_error_detected, test_object_id, rule_id;