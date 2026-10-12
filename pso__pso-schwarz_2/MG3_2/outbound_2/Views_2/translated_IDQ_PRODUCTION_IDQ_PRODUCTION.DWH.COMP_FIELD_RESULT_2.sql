-- discuss naming and purpose with Sergey & KD


CREATE OR REPLACE VIEW idq_production_dwh.comp_field_result_2 (id, leading_test_object_id, dependent_test_object_id,
ref_comp_field_definition_id, leading_field_value, dependent_field_value, is_error_detected,
ref_comp_field_result_type_id, first_negative_test, first_positive_test, error_solved, due_date, flip_count,
first_negative_test_day_id, first_positive_test_day_id, due_day_id, leading_ref_branch_id,
leading_ref_test_object_type_id, leading_ref_country_id, leading_ref_source_system_type_id, leading_ref_source_system_id
, dependent_ref_branch_id, dependent_ref_test_object_type_id, dependent_ref_country_id,
dependent_ref_source_system_type_id, dependent_ref_source_system_id) AS SELECT a.scope_id AS id,
 a.leading_test_object_id,
 a.dependent_test_object_id,
 a.field_comp_definition_id AS ref_comp_field_definition_id,
 a.leading_field_value,
 a.dependent_field_value,
 a.is_error_detected,
 a.field_result_type_id AS ref_comp_field_result_type_id,
 a.first_negative_test,
 a.first_positive_test,
 a.error_solved,
 a.due_date,
 a.flip_count,
 a.first_negative_test_day_id,
 a.first_positive_test_day_id,
 a.due_day_id,
 b.branch_id AS leading_ref_branch_id,
 b.test_object_type_id AS leading_ref_test_object_type_id,
 b.country_id AS leading_ref_country_id,
 rss_l.source_system_type_id AS leading_ref_source_system_type_id,
 b.source_system_id AS leading_ref_source_system_id,
 c.branch_id AS dependent_ref_branch_id,
 c.test_object_type_id AS dependent_ref_test_object_type_id,
 c.country_id AS dependent_ref_country_id,
 rss_d.source_system_type_id AS dependent_ref_source_system_type_id,
 c.source_system_id AS dependent_ref_source_system_id
FROM idq_production_syscomp.comp_field_result_current_2 AS a
 INNER JOIN idq_production_idq_results.idq_test_object_2 AS b ON a.leading_test_object_id = b.id
 INNER JOIN idq_production_idq_results.idq_test_object_2 AS c ON a.dependent_test_object_id = c.id
 INNER JOIN idq_production_idq_results.ref_source_system_2 AS rss_l ON b.source_system_id = rss_l.id
 INNER JOIN idq_production_idq_results.ref_source_system_2 AS rss_d ON c.source_system_id = rss_d.id
WHERE a.is_error_detected = 1;