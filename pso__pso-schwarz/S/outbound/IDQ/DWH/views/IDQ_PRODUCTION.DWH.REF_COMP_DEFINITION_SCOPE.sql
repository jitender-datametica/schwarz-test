CREATE OR REPLACE VIEW idq_production_dwh.ref_comp_definition_scope (ref_comp_definition_scope_id,
ref_comp_definition_id, leading_comp_scope_id, dependent_comp_scope_id, ref_status_id, application_scope_id) AS SELECT
 id AS ref_comp_definition_scope_id,
 comp_definition_id AS ref_comp_definition_id,
 leading_comp_scope_id,
 dependent_comp_scope_id,
 status_id AS ref_status_id,
 application_scope_id
FROM idq_production_idq_results.ref_comp_definition_scope;