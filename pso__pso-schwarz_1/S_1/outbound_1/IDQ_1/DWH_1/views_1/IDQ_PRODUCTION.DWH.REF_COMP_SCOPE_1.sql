CREATE OR REPLACE VIEW idq_production_dwh.ref_comp_scope_1 (ref_comp_scope_id, ref_source_system_type_id,
ref_source_system_id, ref_country_id, ref_branch_id, ref_test_object_type_id, ref_comp_scope_description,
ref_comp_scope_description_de, ref_comp_scope_description_en) AS SELECT id AS ref_comp_scope_id,
 source_system_type_id AS ref_source_system_type_id,
 source_system_id AS ref_source_system_id,
 country_id AS ref_country_id,
 branch_id AS ref_branch_id,
 test_object_type_id AS ref_test_object_type_id,
 description_de AS ref_comp_scope_description,
 description_de AS ref_comp_scope_description_de,
 description_en AS ref_comp_scope_description_en
FROM idq_production_idq_results.ref_comp_scope_1;