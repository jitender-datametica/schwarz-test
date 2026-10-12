CREATE OR REPLACE VIEW idq_production_dwh.comp_field_result (id, leading_test_object_id, dependent_test_object_id,
ref_comp_field_definition_id, leading_field_value, dependent_field_value, is_error_detected,
ref_comp_field_result_type_id, first_negative_test, first_positive_test, error_solved, due_date, flip_count,
first_negative_test_day_id, first_positive_test_day_id, due_day_id, leading_ref_branch_id,
leading_ref_test_object_type_id, leading_ref_country_id, leading_ref_source_system_type_id, leading_ref_source_system_id
, dependent_ref_branch_id, dependent_ref_test_object_type_id, dependent_ref_country_id,
dependent_ref_source_system_type_id, dependent_ref_source_system_id) AS -- discuss naming and purpose with Sergey & KD

SELECT A.scope_id AS id,
 A.leading_test_object_id,
 A.dependent_test_object_id,
 A.field_comp_definition_id AS ref_comp_field_definition_id,
 A.leading_field_value,
 A.dependent_field_value,
 A.is_error_detected,
 A.field_result_type_id AS ref_comp_field_result_type_id,
 A.first_negative_test,
 A.first_positive_test,
 A.error_solved,
 A.due_date,
 A.flip_count,
 A.first_negative_test_day_id,
 A.first_positive_test_day_id,
 A.due_day_id,
 B.branch_id AS leading_ref_branch_id,
 B.test_object_type_id AS leading_ref_test_object_type_id,
 B.country_id AS leading_ref_country_id,
 RSS_L.source_system_type_id AS leading_ref_source_system_type_id,
 B.source_system_id AS leading_ref_source_system_id,
 C.branch_id AS dependent_ref_branch_id,
 C.test_object_type_id AS dependent_ref_test_object_type_id,
 C.country_id AS dependent_ref_country_id,
 RSS_D.source_system_type_id AS dependent_ref_source_system_type_id,
 C.source_system_id AS dependent_ref_source_system_id
FROM idq_production_syscomp.comp_field_result_current AS A
 INNER JOIN idq_production_idq_results.idq_test_object AS B ON A.leading_test_object_id = B.id
 INNER JOIN idq_production_idq_results.idq_test_object AS C ON A.dependent_test_object_id = C.id
 INNER JOIN idq_production_idq_results.ref_source_system AS RSS_L ON B.source_system_id = RSS_L.id
 INNER JOIN idq_production_idq_results.ref_source_system AS RSS_D ON C.source_system_id = RSS_D.id
WHERE A.is_error_detected = 1;