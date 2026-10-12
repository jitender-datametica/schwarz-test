CREATE OR REPLACE VIEW idq_production_idq_results.idq_test_objects_amount_growth_2 AS WITH DAILY_GROWTH AS (SELECT
   ref_source_system_id,
   ref_country_id,
   ref_rule_id,
   ref_test_object_type_id,
   test_result_amount,
   LAG(test_result_amount) OVER (PARTITION BY ref_source_system_id, ref_country_id, ref_rule_id, ref_test_object_type_id
      ORDER BY check_rule_by_country_calculation_time IS NULL, check_rule_by_country_calculation_time) AS previous_value
   
  FROM (SELECT check_rule_by_country_calculation_time,
     test_result_amount,
     ref_source_system_id,
     ref_country_id,
     ref_rule_id,
     ref_test_object_type_id
    FROM idq_production_dwh.check_rule_by_country_summary_2
    WHERE check_rule_by_country_calculation_time > DATETIME_ADD(CURRENT_DATETIME(), INTERVAL -15 DAY)
     AND check_rule_by_country_calculation_time < DATETIME_ADD(CURRENT_DATETIME(), INTERVAL -1 DAY)
    GROUP BY check_rule_by_country_calculation_time,
     ref_source_system_id,
     ref_country_id,
     ref_test_object_type_id,
     ref_rule_id,
     test_result_amount) AS t1_2) (SELECT ref_source_system_id,
   ref_country_id,
   ref_rule_id,
   ref_test_object_type_id,
   AVG(test_result_amount) AS test_result_amount,
   AVG(previous_value) AS previous_value,
      (AVG(test_result_amount) - AVG(previous_value)) / AVG(previous_value) * 100 AS growth_percentage
  FROM DAILY_GROWTH
  WHERE previous_value > 0
  GROUP BY ref_source_system_id,
   ref_country_id,
   ref_rule_id,
   ref_test_object_type_id);