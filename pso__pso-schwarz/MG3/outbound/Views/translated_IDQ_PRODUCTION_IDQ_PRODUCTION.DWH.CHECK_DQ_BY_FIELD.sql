CREATE OR REPLACE VIEW idq_production_dwh.check_dq_by_field (check_dq_by_field_id, ref_field_id, ref_source_system_id,
ref_branch_id, ref_country_id, ref_source_system_type_id, ref_test_object_type_id, check_dq_by_field_calculation_time,
ref_time_calculation_day_id, score, test_object_amount, is_usable, check_dq_by_field_is_current) AS SELECT 1 AS
 check_dq_by_field_id,
 field_id AS ref_field_id,
 source_system_id AS ref_source_system_id,
 branch_id AS ref_branch_id,
 country_id AS ref_country_id,
 source_system_type_id AS ref_source_system_type_id,
 test_object_type_id AS ref_test_object_type_id,
 calculation_time AS check_dq_by_field_calculation_time,
 calculation_day_id AS ref_time_calculation_day_id,
 score,
 test_object_amount,
 is_usable,
 1 AS check_dq_by_field_is_current
FROM idq_production_idq_results.check_dq_by_field_current
UNION ALL
SELECT 1 AS check_dq_by_field_id,
 field_id AS ref_field_id,
 source_system_id AS ref_source_system_id,
 branch_id AS ref_branch_id,
 country_id AS ref_country_id,
 source_system_type_id AS ref_source_system_type_id,
 test_object_type_id AS ref_test_object_type_id,
 calculation_time AS check_dq_by_field_calculation_time,
 calculation_day_id AS ref_time_calculation_day_id,
 score,
 test_object_amount,
 is_usable,
 0 AS check_dq_by_field_is_current
FROM idq_production_idq_results.check_dq_by_field_historical;