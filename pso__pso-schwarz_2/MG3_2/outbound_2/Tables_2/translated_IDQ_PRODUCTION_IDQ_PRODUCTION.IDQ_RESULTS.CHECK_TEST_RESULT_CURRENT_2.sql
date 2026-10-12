DROP TABLE IF EXISTS idq_production_idq_results.check_test_result_current_2;
CREATE OR REPLACE TABLE idq_production_idq_results.check_test_result_current_2 (
scope_id INTEGER,
test_object_id INTEGER,
rule_id INTEGER,
is_error_detected INTEGER,
first_negative_test DATETIME,
first_negative_test_day_id INTEGER,
first_positive_test DATETIME,
first_positive_test_day_id INTEGER,
error_solved INTEGER,
due_date DATETIME,
due_day_id INTEGER,
flip_count INTEGER
) CLUSTER BY is_error_detected, test_object_id, rule_id;