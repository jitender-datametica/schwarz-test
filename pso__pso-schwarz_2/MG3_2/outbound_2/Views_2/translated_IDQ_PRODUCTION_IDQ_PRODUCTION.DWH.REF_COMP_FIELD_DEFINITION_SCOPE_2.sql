CREATE OR REPLACE VIEW idq_production_dwh.ref_comp_field_definition_scope_2 (ref_comp_field_definition_scope_id,
ref_comp_definition_scope_id, ref_comp_field_definition_id, ref_criticality_id, ref_field_comp_type_id, ref_status_id,
ref_comp_definition_id, leading_comp_scope_id, dependent_comp_scope_id, leading_field_id, dependent_field_id,
leading_ref_source_system_type_id, leading_ref_source_system_id, leading_ref_country_id, leading_ref_branch_id,
leading_ref_test_object_type_id, dependent_ref_source_system_type_id, dependent_ref_source_system_id,
dependent_ref_country_id, dependent_ref_branch_id, dependent_ref_test_object_type_id) AS SELECT cfds.id AS
 ref_comp_field_definition_scope_id,
 cfds.comp_definition_scope_id AS ref_comp_definition_scope_id,
 cfds.comp_field_definition_id AS ref_comp_field_definition_id,
 cfds.criticality_id AS ref_criticality_id,
 cfds.field_comp_type_id AS ref_field_comp_type_id,
 cfds.status_id AS ref_status_id,
 cds.comp_definition_id AS ref_comp_definition_id,
 cds.leading_comp_scope_id,
 cds.dependent_comp_scope_id,
 cfd.leading_field_id,
 cfd.dependent_field_id,
 ls.source_system_type_id AS leading_ref_source_system_type_id,
 ls.source_system_id AS leading_ref_source_system_id,
 ls.country_id AS leading_ref_country_id,
 ls.branch_id AS leading_ref_branch_id,
 ls.test_object_type_id AS leading_ref_test_object_type_id,
 ds.source_system_type_id AS dependent_ref_source_system_type_id,
 ds.source_system_id AS dependent_ref_source_system_id,
 ds.country_id AS dependent_ref_country_id,
 ds.branch_id AS dependent_ref_branch_id,
 ds.test_object_type_id AS dependent_ref_test_object_type_id
FROM idq_production_idq_results.ref_comp_definition_scope_2 AS cds
 INNER JOIN idq_production_idq_results.ref_comp_scope_2 AS ls ON cds.leading_comp_scope_id = ls.id
 INNER JOIN idq_production_idq_results.ref_comp_scope_2 AS ds ON cds.dependent_comp_scope_id = ds.id
 LEFT JOIN idq_production_idq_results.ref_comp_field_definition_scope_2 AS cfds ON cds.id = cfds.comp_definition_scope_id
 LEFT JOIN idq_production_idq_results.ref_comp_field_definition_2 AS cfd ON cfds.comp_field_definition_id = cfd.id;