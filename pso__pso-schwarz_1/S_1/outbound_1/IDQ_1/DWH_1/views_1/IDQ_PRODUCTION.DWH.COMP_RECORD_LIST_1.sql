CREATE OR REPLACE VIEW idq_production_dwh.comp_record_list_1 (comp_scope_execution_id, comp_definition_scope_id,
execution_date, execution_day_id, ref_comp_definition_id, leading_comp_scope_id, dependent_comp_scope_id,
leading_ref_source_system_type_id, leading_ref_source_system_id, leading_ref_country_id, leading_ref_branch_id,
leading_ref_test_object_type_id, dependent_ref_source_system_type_id, dependent_ref_source_system_id,
dependent_ref_country_id, dependent_ref_branch_id, dependent_ref_test_object_type_id, leading_test_object_id,
dependent_test_object_id, ref_matching_status_id, unmatched_tables, scope_id) AS SELECT CRL.comp_scope_execution_id,
 SEC.comp_definition_scope_id,
 SEC.execution_date,
 SEC.execution_day_id,
 RCDS.comp_definition_id AS ref_comp_definition_id,
 RCDS.leading_comp_scope_id,
 RCDS.dependent_comp_scope_id,
 RSL.source_system_type_id AS leading_ref_source_system_type_id,
 RSL.source_system_id AS leading_ref_source_system_id,
 RSL.country_id AS leading_ref_country_id,
 RSL.branch_id AS leading_ref_branch_id,
 RSL.test_object_type_id AS leading_ref_test_object_type_id,
 RSD.source_system_type_id AS dependent_ref_source_system_type_id,
 RSD.source_system_id AS dependent_ref_source_system_id,
 RSD.country_id AS dependent_ref_country_id,
 RSD.branch_id AS dependent_ref_branch_id,
 RSD.test_object_type_id AS dependent_ref_test_object_type_id,
 CRL.leading_test_object_id,
 CRL.dependent_test_object_id,
 CRL.matching_status_id AS ref_matching_status_id,
 CRL.unmatched_tables,
 CRL.scope_id
FROM idq_production_syscomp.comp_record_list_1 AS CRL
 INNER JOIN idq_production_syscomp.comp_scope_execution_current_1 AS SEC ON CRL.comp_scope_execution_id = SEC.id
 INNER JOIN idq_production_idq_results.ref_comp_definition_scope_1 AS RCDS ON SEC.comp_definition_scope_id = RCDS.id
 INNER JOIN idq_production_idq_results.ref_comp_scope_1 AS RSL ON RCDS.leading_comp_scope_id = RSL.id
 INNER JOIN idq_production_idq_results.ref_comp_scope_1 AS RSD ON RCDS.dependent_comp_scope_id = RSD.id;