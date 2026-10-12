CREATE OR REPLACE VIEW idq_production_dwh.check_dq_by_field_and_test_object_2 (check_dq_by_field_and_test_object_id,
idq_test_object_id, ref_branch_id, ref_country_id, ref_source_system_type_id, ref_test_object_type_id, ref_field_id,
check_dq_by_field_and_test_object_calculation_time, ref_time_calculation_day_id, penalty, score, is_usable, is_relevant
, ref_source_system_id) AS SELECT 1 AS check_dq_by_field_and_test_object_id,
 CDFTO.test_object_id AS idq_test_object_id,
 CDFTO.branch_id AS ref_branch_id,
 CDFTO.country_id AS ref_country_id,
 CDFTO.source_system_type_id AS ref_source_system_type_id,
 CDFTO.test_object_type_id AS ref_test_object_type_id,
 CDFTO.field_id AS ref_field_id,
 CDFTO.calculation_time AS check_dq_by_field_and_test_object_calculation_time,
 CDFTO.calculation_day_id AS ref_time_calculation_day_id,
 CDFTO.penalty,
 CDFTO.score,
 CDFTO.is_usable,
 ITO.is_relevant,
 ITO.source_system_id AS ref_source_system_id
FROM idq_production_idq_results.check_dq_by_field_and_test_object_current_2 AS CDFTO
 INNER JOIN idq_production_idq_results.idq_test_object_2 AS ITO ON CDFTO.test_object_id = ITO.id;