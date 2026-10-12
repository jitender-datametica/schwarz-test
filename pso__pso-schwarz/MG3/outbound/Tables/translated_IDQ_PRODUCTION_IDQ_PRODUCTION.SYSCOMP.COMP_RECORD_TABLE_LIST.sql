CREATE OR REPLACE TABLE idq_production_syscomp.comp_record_table_list (
comp_scope_table_execution_id INTEGER,
leading_test_object_id INTEGER,
dependent_test_object_id INTEGER,
matching_status_id INTEGER,
missing_in_table STRING(50),
scope_id INTEGER
);