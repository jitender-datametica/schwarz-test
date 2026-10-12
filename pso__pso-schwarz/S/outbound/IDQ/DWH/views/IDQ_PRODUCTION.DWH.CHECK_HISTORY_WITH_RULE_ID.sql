CREATE OR REPLACE VIEW idq_production_dwh.check_history_with_rule_id (ref_calculation_time, ref_time_calculation_day_id
, ref_source_system_id, ref_branch_id, ref_country_id, ref_source_system_type_id, ref_test_object_type_id, ref_rule_id,
test_object_amount, error_amount, check_history_is_current) AS SELECT calculation_time,
 calculation_day_id AS ref_time_calculation_day_id,
 source_system_id AS ref_source_system_id,
 branch_id AS ref_branch_id,
 country_id AS ref_country_id,
 source_system_type_id AS ref_source_system_type_id,
 test_object_type_id AS ref_test_object_type_id,
 rule_id AS ref_rule_id,
 test_result_amount AS test_object_amount,
 error_amount,
 1 AS check_history_is_current
FROM idq_production_idq_results.check_rule_by_scope_current
UNION ALL
SELECT calculation_time AS check_history_calculation_time,
 calculation_day_id AS ref_time_calculation_day_id,
 source_system_id AS ref_source_system_id,
 branch_id AS ref_branch_id,
 country_id AS ref_country_id,
 source_system_type_id AS ref_source_system_type_id,
 test_object_type_id AS ref_test_object_type_id,
 rule_id AS ref_rule_id,
 test_result_amount AS test_object_amount,
 error_amount,
 0 AS check_history_is_current
FROM idq_production_idq_results.check_rule_by_scope_historical
WHERE calculation_time >= DATETIME_ADD(CAST(CONCAT(SUBSTR(CAST(CURRENT_DATETIME() AS STRING), 0, 10), ' 18:00:00') AS DATETIME)
   ,INTERVAL - 7 DAY);