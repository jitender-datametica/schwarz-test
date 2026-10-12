CREATE OR REPLACE VIEW idq_production_dwh.ref_comp_field_definition_scope (ref_comp_field_definition_scope_id,
ref_comp_definition_scope_id, ref_comp_field_definition_id, ref_criticality_id, ref_field_comp_type_id, ref_status_id,
ref_comp_definition_id, leading_comp_scope_id, dependent_comp_scope_id, leading_field_id, dependent_field_id,
leading_ref_source_system_type_id, leading_ref_source_system_id, leading_ref_country_id, leading_ref_branch_id,
leading_ref_test_object_type_id, dependent_ref_source_system_type_id, dependent_ref_source_system_id,
dependent_ref_country_id, dependent_ref_branch_id, dependent_ref_test_object_type_id) AS SELECT CFDS.id AS
 ref_comp_field_definition_scope_id,
 CFDS.comp_definition_scope_id AS ref_comp_definition_scope_id,
 CFDS.comp_field_definition_id AS ref_comp_field_definition_id,
 CFDS.criticality_id AS ref_criticality_id,
 CFDS.field_comp_type_id AS ref_field_comp_type_id,
 CFDS.status_id AS ref_status_id,
 CDS.comp_definition_id AS ref_comp_definition_id,
 CDS.leading_comp_scope_id,
 CDS.dependent_comp_scope_id,
 CFD.leading_field_id,
 CFD.dependent_field_id,
 LS.source_system_type_id AS leading_ref_source_system_type_id,
 LS.source_system_id AS leading_ref_source_system_id,
 LS.country_id AS leading_ref_country_id,
 LS.branch_id AS leading_ref_branch_id,
 LS.test_object_type_id AS leading_ref_test_object_type_id,
 DS.source_system_type_id AS dependent_ref_source_system_type_id,
 DS.source_system_id AS dependent_ref_source_system_id,
 DS.country_id AS dependent_ref_country_id,
 DS.branch_id AS dependent_ref_branch_id,
 DS.test_object_type_id AS dependent_ref_test_object_type_id
FROM idq_production_idq_results.ref_comp_definition_scope AS CDS
 INNER JOIN idq_production_idq_results.ref_comp_scope AS LS ON CDS.leading_comp_scope_id = LS.id
 INNER JOIN idq_production_idq_results.ref_comp_scope AS DS ON CDS.dependent_comp_scope_id = DS.id
 LEFT JOIN idq_production_idq_results.ref_comp_field_definition_scope AS CFDS ON CDS.id = CFDS.comp_definition_scope_id
 LEFT JOIN idq_production_idq_results.ref_comp_field_definition AS CFD ON CFDS.comp_field_definition_id = CFD.id;