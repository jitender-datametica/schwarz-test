CREATE OR REPLACE VIEW idq_production_dwh.check_test_result (check_test_result_id, idq_test_object_id, ref_rule_id,
is_error_detected, first_negative_test, ref_time_first_negative_test_day_id, first_positive_test,
ref_time_first_positive_test_day_id, error_solved, due_date, ref_time_due_day_id, flip_count, ref_field_id,
ref_source_system_type_id, ref_source_system_id, ref_branch_id, ref_country_id, ref_test_object_type_id,
ref_criticality_id, ref_dimension_id, ref_test_object_type_level_1_id, ref_test_object_type_level_2_id,
ref_test_object_type_level_3_id) AS SELECT 10000 * CAST(ctr.test_object_id AS BIGNUMERIC) + ctr.rule_id AS
 check_test_result_id,
 ctr.test_object_id AS idq_test_object_id,
 ctr.rule_id AS ref_rule_id,
 ctr.is_error_detected,
 ctr.first_negative_test,
 ctr.first_negative_test_day_id AS ref_time_first_negative_test_day_id,
 ctr.first_positive_test,
 ctr.first_positive_test_day_id AS ref_time_first_positive_test_day_id,
 ctr.error_solved,
 ctr.due_date,
 ctr.due_day_id AS ref_time_due_day_id,
 ctr.flip_count,
 rr.field_id AS ref_field_id,
 srs.source_system_type_id AS ref_source_system_type_id,
 ito.source_system_id AS ref_source_system_id,
 ito.branch_id AS ref_branch_id,
 ito.country_id AS ref_country_id,
 ito.test_object_type_id AS ref_test_object_type_id,
 rr.criticality_id AS ref_criticality_id,
 rr.dimension_id AS ref_dimension_id,
 tote.level_1_id AS ref_test_object_type_level_1_id,
 tote.level_2_id AS ref_test_object_type_level_2_id,
 tote.level_3_id AS ref_test_object_type_level_3_id
FROM idq_production_idq_results.check_test_result_current AS ctr
 INNER JOIN idq_production_idq_results.idq_test_object AS ito ON ctr.test_object_id = ito.id AND ctr.is_error_detected =
   1
 INNER JOIN idq_production_idq_results.ref_source_system AS srs ON ito.source_system_id = srs.id
 INNER JOIN idq_production_idq_results.ref_rule AS rr ON ctr.rule_id = rr.id
 INNER JOIN idq_production_idq_results.ref_criticality AS crt ON rr.criticality_id = crt.id
 INNER JOIN idq_production_idq_results.ref_test_object_type_extended AS tote ON ito.test_object_type_id = tote.id;