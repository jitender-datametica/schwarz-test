CREATE OR REPLACE TABLE idq_production_syscomp.comp_record_list_2 (
comp_scope_execution_id BIGNUMERIC(38,0),
leading_test_object_id BIGNUMERIC(38,0),
dependent_test_object_id BIGNUMERIC(38,0),
matching_status_id BIGNUMERIC(38,0),
unmatched_tables STRING(200),
scope_id BIGNUMERIC(38,0)
);