CREATE OR REPLACE TABLE idq_production_syscomp.comp_field_list (
scope_id INTEGER NOT NULL,
comp_field_definition_id INTEGER NOT NULL,
comp_record_execution_id INTEGER NOT NULL,
leading_test_object_id INTEGER NOT NULL,
dependent_test_object_id INTEGER NOT NULL,
leading_field_value STRING(200),
dependent_field_value STRING(200),
field_result_type_id INTEGER
);