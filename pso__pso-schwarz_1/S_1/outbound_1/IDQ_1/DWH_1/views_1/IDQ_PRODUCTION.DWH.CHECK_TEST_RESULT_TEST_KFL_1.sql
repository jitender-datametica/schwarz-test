CREATE OR REPLACE VIEW idq_production_dwh.check_test_result_test_kfl_1 (check_test_result_id, idq_test_object_id,
ref_rule_id, is_error_detected, first_negative_test, ref_time_first_negative_test_day_id, first_positive_test,
ref_time_first_positive_test_day_id, error_solved, due_date, ref_time_due_day_id, flip_count, ref_field_id,
ref_source_system_type_id, ref_source_system_id, ref_branch_id, ref_country_id, ref_test_object_type_id,
ref_criticality_id, ref_dimension_id, ref_test_object_type_level_1_id, ref_test_object_type_level_2_id,
ref_test_object_type_level_3_id) AS SELECT 10000 * CAST(CTR.test_object_id AS BIGNUMERIC) + CTR.rule_id AS
 check_test_result_id,
 CTR.test_object_id AS idq_test_object_id,
 CTR.rule_id AS ref_rule_id,
 CTR.is_error_detected,
 CTR.first_negative_test,
 CTR.first_negative_test_day_id AS ref_time_first_negative_test_day_id,
 CTR.first_positive_test,
 CTR.first_positive_test_day_id AS ref_time_first_positive_test_day_id,
 CTR.error_solved,
 CTR.due_date,
 CTR.due_day_id AS ref_time_due_day_id,
 CTR.flip_count,
 RR.field_id AS ref_field_id,
 SRS.source_system_type_id AS ref_source_system_type_id,
 ITO.source_system_id AS ref_source_system_id,
 ITO.branch_id AS ref_branch_id,
 ITO.country_id AS ref_country_id,
 ITO.test_object_type_id AS ref_test_object_type_id,
 RR.criticality_id AS ref_criticality_id,
 RR.dimension_id AS ref_dimension_id,
 TOTE.level_1_id AS ref_test_object_type_level_1_id,
 TOTE.level_2_id AS ref_test_object_type_level_2_id,
 TOTE.level_3_id AS ref_test_object_type_level_3_id
FROM idq_production_idq_results.check_test_result_current_1 AS CTR
 INNER JOIN idq_production_idq_results.idq_test_object_1 AS ITO ON CTR.test_object_id = ITO.id
 INNER JOIN idq_production_idq_results.ref_source_system_1 AS SRS ON ITO.source_system_id = SRS.id
 INNER JOIN idq_production_idq_results.ref_rule_1 AS RR ON CTR.rule_id = RR.id
 INNER JOIN idq_production_idq_results.ref_criticality_1 AS CRT ON RR.criticality_id = CRT.id
 INNER JOIN idq_production_idq_results.ref_test_object_type_extended_1 AS TOTE ON ITO.test_object_type_id = TOTE.id
WHERE CTR.is_error_detected = 1
 AND SRS.source_system_type_id = 14;