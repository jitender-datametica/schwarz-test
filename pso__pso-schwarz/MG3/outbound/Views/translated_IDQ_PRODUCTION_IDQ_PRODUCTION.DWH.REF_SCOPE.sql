CREATE OR REPLACE VIEW idq_production_dwh.ref_scope (ref_scope_id, ref_source_system_type_id, ref_source_system_id,
ref_country_id, ref_branch_id, ref_test_object_type_id, contact_email) AS SELECT id AS ref_scope_id,
 source_system_type_id AS ref_source_system_type_id,
 source_system_id AS ref_source_system_id,
 country_id AS ref_country_id,
 branch_id AS ref_branch_id,
 test_object_type_id AS ref_test_object_type_id,
 contact_email
FROM idq_production_idq_results.ref_scope;