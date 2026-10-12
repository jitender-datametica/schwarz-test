CREATE OR REPLACE VIEW idq_production_dwh.comp_record_list (comp_scope_execution_id, comp_definition_scope_id,
execution_date, execution_day_id, ref_comp_definition_id, leading_comp_scope_id, dependent_comp_scope_id,
leading_ref_source_system_type_id, leading_ref_source_system_id, leading_ref_country_id, leading_ref_branch_id,
leading_ref_test_object_type_id, dependent_ref_source_system_type_id, dependent_ref_source_system_id,
dependent_ref_country_id, dependent_ref_branch_id, dependent_ref_test_object_type_id, leading_test_object_id,
dependent_test_object_id, ref_matching_status_id, unmatched_tables, scope_id) AS SELECT crl.comp_scope_execution_id,
 sec.comp_definition_scope_id,
 sec.execution_date,
 sec.execution_day_id,
 rcds.comp_definition_id AS ref_comp_definition_id,
 rcds.leading_comp_scope_id,
 rcds.dependent_comp_scope_id,
 rsl.source_system_type_id AS leading_ref_source_system_type_id,
 rsl.source_system_id AS leading_ref_source_system_id,
 rsl.country_id AS leading_ref_country_id,
 rsl.branch_id AS leading_ref_branch_id,
 rsl.test_object_type_id AS leading_ref_test_object_type_id,
 rsd.source_system_type_id AS dependent_ref_source_system_type_id,
 rsd.source_system_id AS dependent_ref_source_system_id,
 rsd.country_id AS dependent_ref_country_id,
 rsd.branch_id AS dependent_ref_branch_id,
 rsd.test_object_type_id AS dependent_ref_test_object_type_id,
 crl.leading_test_object_id,
 crl.dependent_test_object_id,
 crl.matching_status_id AS ref_matching_status_id,
 crl.unmatched_tables,
 crl.scope_id
FROM idq_production_syscomp.comp_record_list AS crl
 INNER JOIN idq_production_syscomp.comp_scope_execution_current AS sec ON crl.comp_scope_execution_id = sec.id
 INNER JOIN idq_production_idq_results.ref_comp_definition_scope AS rcds ON sec.comp_definition_scope_id = rcds.id
 INNER JOIN idq_production_idq_results.ref_comp_scope AS rsl ON rcds.leading_comp_scope_id = rsl.id
 INNER JOIN idq_production_idq_results.ref_comp_scope AS rsd ON rcds.dependent_comp_scope_id = rsd.id;