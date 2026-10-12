CREATE OR REPLACE TABLE idq_production_syscomp.comp_field_result_current_2 (
scope_id INTEGER,
leading_test_object_id INTEGER,
dependent_test_object_id INTEGER,
field_comp_definition_id INTEGER,
leading_field_value STRING(200),
dependent_field_value STRING(200),
is_error_detected INTEGER NOT NULL,
field_result_type_id INTEGER NOT NULL,
first_negative_test DATETIME,
first_positive_test DATETIME,
error_solved INTEGER NOT NULL,
due_date DATETIME,
flip_count INTEGER NOT NULL,
first_negative_test_day_id INTEGER NOT NULL,
first_positive_test_day_id INTEGER NOT NULL,
due_day_id INTEGER NOT NULL
);