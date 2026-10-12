CREATE OR REPLACE TABLE idq_production_syscomp.comp_field_result_current (
scope_id BIGNUMERIC(38,0),
leading_test_object_id BIGNUMERIC(38,0),
dependent_test_object_id BIGNUMERIC(38,0),
field_comp_definition_id BIGNUMERIC(38,0),
leading_field_value STRING(2000),
dependent_field_value STRING(2000),
is_error_detected BIGNUMERIC(38,0) NOT NULL,
field_result_type_id BIGNUMERIC(38,0) NOT NULL,
first_negative_test DATETIME,
first_positive_test DATETIME,
error_solved BIGNUMERIC(38,0) NOT NULL,
due_date DATETIME,
flip_count BIGNUMERIC(38,0) NOT NULL,
first_negative_test_day_id BIGNUMERIC(38,0) NOT NULL,
first_positive_test_day_id BIGNUMERIC(38,0) NOT NULL,
due_day_id BIGNUMERIC(38,0) NOT NULL
);