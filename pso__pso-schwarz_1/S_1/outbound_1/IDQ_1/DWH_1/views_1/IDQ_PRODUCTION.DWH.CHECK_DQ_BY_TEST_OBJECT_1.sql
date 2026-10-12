CREATE OR REPLACE VIEW idq_production_dwh.check_dq_by_test_object_1 (check_dq_by_test_object_id, idq_test_object_id,
ref_branch_id, ref_country_id, ref_source_system_type_id, ref_test_object_type_id,
check_dq_by_test_object_calculation_time, ref_time_calculation_day_id, penalty, score, field_amount, is_usable,
check_dq_by_test_object_is_current, is_relevant, ref_source_system_id) AS SELECT 1 AS check_dq_by_test_object_id,
 CDTO.test_object_id AS idq_test_object_id,
 CDTO.branch_id AS ref_branch_id,
 CDTO.country_id AS ref_country_id,
 CDTO.source_system_type_id AS ref_source_system_type_id,
 CDTO.test_object_type_id AS ref_test_object_type_id,
 CDTO.calculation_time AS check_dq_by_test_object_calculation_time,
 CDTO.calculation_day_id AS ref_time_calculation_day_id,
 CDTO.penalty,
 CDTO.score,
 CDTO.field_amount,
 CDTO.is_usable,
 1 AS check_dq_by_test_object_is_current,
 ITO.is_relevant,
 ITO.source_system_id AS ref_source_system_id
FROM idq_production_idq_results.check_dq_by_test_object_current_1 AS CDTO
 INNER JOIN idq_production_idq_results.idq_test_object_1 AS ITO ON CDTO.test_object_id = ITO.id
UNION ALL
SELECT 1 AS check_dq_by_test_object_id,
 CDTO.test_object_id AS idq_test_object_id,
 CDTO.branch_id AS ref_branch_id,
 CDTO.country_id AS ref_country_id,
 CDTO.source_system_type_id AS ref_source_system_type_id,
 CDTO.test_object_type_id AS ref_test_object_type_id,
 CDTO.calculation_time AS check_dq_by_test_object_calculation_time,
 CDTO.calculation_day_id AS ref_time_calculation_day_id,
 CDTO.penalty,
 CDTO.score,
 CDTO.field_amount,
 CDTO.is_usable,
 0 AS check_dq_by_test_object_is_current,
 ITO.is_relevant,
 ITO.source_system_id AS ref_source_system_id
FROM idq_production_idq_results.check_dq_by_test_object_historical_1 AS CDTO
 INNER JOIN idq_production_idq_results.idq_test_object_1 AS ITO ON CDTO.test_object_id = ITO.id;