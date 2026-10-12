CREATE OR REPLACE VIEW idq_production_dwh.reporting_rule_by_country_summary_1 (reporting_rule_by_country_summary_id,
reporting_rule_by_country_summary_calculation_time, ref_time_calculation_day_id, ref_source_system_id,
ref_source_system_type_id, ref_country_id, ref_branch_id, ref_rule_id, ref_dimension_id, ref_test_object_type_id,
test_result_amount, included_amount, excluded_amount, reporting_rule_by_country_summary_is_current) AS SELECT ROW_NUMBER()
 OVER (ORDER BY ref_time_calculation_day_id IS NULL, ref_time_calculation_day_id) AS
 reporting_rule_by_country_summary_id,
 reporting_rule_by_country_summary_calculation_time,
 ref_time_calculation_day_id,
 ref_source_system_id,
 ref_source_system_type_id,
 ref_country_id,
 ref_branch_id,
 ref_rule_id,
 ref_dimension_id,
 ref_test_object_type_id,
 test_result_amount,
 included_amount,
 excluded_amount,
 reporting_rule_by_country_summary_is_current
FROM (SELECT rrcs.calculation_time AS reporting_rule_by_country_summary_calculation_time,
    rrcs.calculation_day_id AS ref_time_calculation_day_id,
    rrcs.source_system_id AS ref_source_system_id,
    rrcs.source_system_type_id AS ref_source_system_type_id,
    rrcs.country_id AS ref_country_id,
    rrcs.branch_id AS ref_branch_id,
    rrcs.rule_id AS ref_rule_id,
    rr.dimension_id AS ref_dimension_id,
    rrcs.test_object_type_id AS ref_test_object_type_id,
    rrcs.test_result_amount,
    rrcs.included_amount,
    rrcs.excluded_amount,
    1 AS reporting_rule_by_country_summary_is_current
   FROM idq_production_idq_results.reporting_dq_by_country_current_1 AS rrcs
    INNER JOIN idq_production_idq_results.ref_rule_1 AS rr ON rrcs.rule_id = rr.id
   UNION ALL
   SELECT rrcsh.calculation_time AS reporting_rule_by_country_summary_calculation_time,
    rrcsh.calculation_day_id AS ref_time_calculation_day_id,
    rrcsh.source_system_id AS ref_source_system_id,
    rrcsh.source_system_type_id AS ref_source_system_type_id,
    rrcsh.country_id AS ref_country_id,
    rrcsh.branch_id AS ref_branch_id,
    rrcsh.rule_id AS ref_rule_id,
    rr.dimension_id AS ref_dimension_id,
    rrcsh.test_object_type_id AS ref_test_object_type_id,
    rrcsh.test_result_amount,
    rrcsh.included_amount,
    rrcsh.excluded_amount,
    0 AS reporting_rule_by_country_summary_is_current
   FROM idq_production_idq_results.reporting_dq_by_country_historical_1 AS rrcsh
    INNER JOIN idq_production_idq_results.ref_rule_1 AS rr ON rrcsh.rule_id = rr.id) AS REPORTING_DQ_BY_COUNTRY;