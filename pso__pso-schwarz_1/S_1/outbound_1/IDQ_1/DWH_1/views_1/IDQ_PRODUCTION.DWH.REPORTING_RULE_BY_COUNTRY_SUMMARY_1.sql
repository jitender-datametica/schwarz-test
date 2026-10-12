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
FROM (SELECT RRCS.calculation_time AS reporting_rule_by_country_summary_calculation_time,
    RRCS.calculation_day_id AS ref_time_calculation_day_id,
    RRCS.source_system_id AS ref_source_system_id,
    RRCS.source_system_type_id AS ref_source_system_type_id,
    RRCS.country_id AS ref_country_id,
    RRCS.branch_id AS ref_branch_id,
    RRCS.rule_id AS ref_rule_id,
    RR.dimension_id AS ref_dimension_id,
    RRCS.test_object_type_id AS ref_test_object_type_id,
    RRCS.test_result_amount,
    RRCS.included_amount,
    RRCS.excluded_amount,
    1 AS reporting_rule_by_country_summary_is_current
   FROM idq_production_idq_results.reporting_dq_by_country_current_1 AS RRCS
    INNER JOIN idq_production_idq_results.ref_rule_1 AS RR ON RRCS.rule_id = RR.id
   UNION ALL
   SELECT RRCSH.calculation_time AS reporting_rule_by_country_summary_calculation_time,
    RRCSH.calculation_day_id AS ref_time_calculation_day_id,
    RRCSH.source_system_id AS ref_source_system_id,
    RRCSH.source_system_type_id AS ref_source_system_type_id,
    RRCSH.country_id AS ref_country_id,
    RRCSH.branch_id AS ref_branch_id,
    RRCSH.rule_id AS ref_rule_id,
    RR.dimension_id AS ref_dimension_id,
    RRCSH.test_object_type_id AS ref_test_object_type_id,
    RRCSH.test_result_amount,
    RRCSH.included_amount,
    RRCSH.excluded_amount,
    0 AS reporting_rule_by_country_summary_is_current
   FROM idq_production_idq_results.reporting_dq_by_country_historical_1 AS RRCSH
    INNER JOIN idq_production_idq_results.ref_rule_1 AS RR ON RRCSH.rule_id = RR.id) AS REPORTING_DQ_BY_COUNTRY;