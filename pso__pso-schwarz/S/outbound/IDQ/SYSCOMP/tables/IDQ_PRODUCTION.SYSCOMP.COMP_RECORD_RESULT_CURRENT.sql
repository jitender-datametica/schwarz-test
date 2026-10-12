CREATE OR REPLACE TABLE idq_production_syscomp.comp_record_result_current (
scope_id BIGNUMERIC(38,0) NOT NULL,
comp_definition_scope_id BIGNUMERIC(38,0) NOT NULL,
leading_test_object_id BIGNUMERIC(38,0) NOT NULL,
dependent_test_object_id BIGNUMERIC(38,0) NOT NULL,
matching_status_id BIGNUMERIC(38,0) NOT NULL,
unmatched_tables STRING(200),
first_negative_test DATETIME,
first_positive_test DATETIME,
error_solved BIGNUMERIC(38,0) NOT NULL,
flip_count BIGNUMERIC(38,0) NOT NULL,
due_date DATETIME,
first_negative_test_day_id BIGNUMERIC(38,0) NOT NULL,
first_positive_test_day_id BIGNUMERIC(38,0) NOT NULL,
due_day_id BIGNUMERIC(38,0) NOT NULL
);