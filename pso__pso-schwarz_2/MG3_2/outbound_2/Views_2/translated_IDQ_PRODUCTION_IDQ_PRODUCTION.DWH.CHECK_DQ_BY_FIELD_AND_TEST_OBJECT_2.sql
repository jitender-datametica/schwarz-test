CREATE OR REPLACE VIEW idq_production_dwh.check_dq_by_field_and_test_object_2 (check_dq_by_field_and_test_object_id,
idq_test_object_id, ref_branch_id, ref_country_id, ref_source_system_type_id, ref_test_object_type_id, ref_field_id,
check_dq_by_field_and_test_object_calculation_time, ref_time_calculation_day_id, penalty, score, is_usable, is_relevant
, ref_source_system_id) AS SELECT 1 AS check_dq_by_field_and_test_object_id,
 cdfto.test_object_id AS idq_test_object_id,
 cdfto.branch_id AS ref_branch_id,
 cdfto.country_id AS ref_country_id,
 cdfto.source_system_type_id AS ref_source_system_type_id,
 cdfto.test_object_type_id AS ref_test_object_type_id,
 cdfto.field_id AS ref_field_id,
 cdfto.calculation_time AS check_dq_by_field_and_test_object_calculation_time,
 cdfto.calculation_day_id AS ref_time_calculation_day_id,
 cdfto.penalty,
 cdfto.score,
 cdfto.is_usable,
 ito.is_relevant,
 ito.source_system_id AS ref_source_system_id
FROM idq_production_idq_results.check_dq_by_field_and_test_object_current_2 AS cdfto
 INNER JOIN idq_production_idq_results.idq_test_object_2 AS ito ON cdfto.test_object_id = ito.id;