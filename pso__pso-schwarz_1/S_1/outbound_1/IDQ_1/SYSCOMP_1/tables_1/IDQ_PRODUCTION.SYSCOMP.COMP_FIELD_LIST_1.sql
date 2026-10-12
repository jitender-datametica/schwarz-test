CREATE OR REPLACE TABLE idq_production_syscomp.comp_field_list_1 (
scope_id BIGNUMERIC(38,0) NOT NULL,
comp_field_definition_id BIGNUMERIC(38,0) NOT NULL,
comp_record_execution_id BIGNUMERIC(38,0) NOT NULL,
leading_test_object_id BIGNUMERIC(38,0) NOT NULL,
dependent_test_object_id BIGNUMERIC(38,0) NOT NULL,
leading_field_value STRING(2000),
dependent_field_value STRING(2000),
field_result_type_id BIGNUMERIC(38,0)
);