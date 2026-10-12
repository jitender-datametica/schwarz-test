CREATE OR REPLACE VIEW idq_production_dwh.ref_comp_definition_2 (ref_comp_definition_id, leading_source_system_type_id,
dependent_source_system_type_id, leading_test_object_type_id, dependent_test_object_type_id, name, name_de, name_en) AS
SELECT id AS ref_comp_definition_id,
 leading_source_system_type_id,
 dependent_source_system_type_id,
 leading_test_object_type_id,
 dependent_test_object_type_id,
 name,
 name_de,
 name_en
FROM idq_production_idq_results.ref_comp_definition_2;