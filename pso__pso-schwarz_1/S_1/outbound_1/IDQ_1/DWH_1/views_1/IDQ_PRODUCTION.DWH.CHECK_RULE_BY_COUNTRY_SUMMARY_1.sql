CREATE OR REPLACE VIEW idq_production_dwh.check_rule_by_country_summary_1 (check_rule_by_country_summary_id,
check_rule_by_country_calculation_time, ref_time_calculation_day_id, ref_source_system_id, ref_branch_id, ref_country_id
, ref_source_system_type_id, ref_test_object_type_id, ref_rule_id, ref_field_id, ref_criticality_id, ref_dimension_id,
test_result_amount, error_amount, no_error_amount, solved_error_amount, new_error_amount, flip_error_amount,
earliest_due_date, ref_time_earliest_due_day_id, overdue_amount, ref_status_id, check_rule_by_country_is_current,
newly_solved_error_amount, exclude_flag) AS SELECT ROW_NUMBER() OVER (ORDER BY ref_time_calculation_day_id IS NULL,
    ref_time_calculation_day_id) AS check_rule_by_country_summary_id,
 check_rule_by_country_calculation_time,
 ref_time_calculation_day_id,
 ref_source_system_id,
 ref_branch_id,
 ref_country_id,
 ref_source_system_type_id,
 ref_test_object_type_id,
 ref_rule_id,
 ref_field_id,
 ref_criticality_id,
 ref_dimension_id,
 test_result_amount,
 error_amount,
 no_error_amount,
 solved_error_amount,
 new_error_amount,
 flip_error_amount,
 earliest_due_date,
 ref_time_earliest_due_day_id,
 overdue_amount,
 ref_status_id,
 check_rule_by_country_is_current,
 newly_solved_error_amount,
 exclude_flag
FROM (SELECT CRCS.calculation_time AS check_rule_by_country_calculation_time,
    CRCS.calculation_day_id AS ref_time_calculation_day_id,
    CRCS.source_system_id AS ref_source_system_id,
    CRCS.branch_id AS ref_branch_id,
    CRCS.country_id AS ref_country_id,
    CRCS.source_system_type_id AS ref_source_system_type_id,
    CRCS.test_object_type_id AS ref_test_object_type_id,
    CRCS.rule_id AS ref_rule_id,
    RR.field_id AS ref_field_id,
    RR.criticality_id AS ref_criticality_id,
    RR.dimension_id AS ref_dimension_id,
    CRCS.test_result_amount,
    CRCS.error_amount,
    CRCS.no_error_amount,
    CRCS.solved_error_amount,
    CRCS.new_error_amount,
    CRCS.flip_error_amount,
    CRCS.earliest_due_date,
    CRCS.earliest_due_day_id AS ref_time_earliest_due_day_id,
    CRCS.overdue_amount,
    CRCS.status_id AS ref_status_id,
    1 AS check_rule_by_country_is_current,
    CRCS.newly_solved_error_amount,
     CASE
     WHEN RE.exclude_flag IS NOT NULL
     THEN RE.exclude_flag
     ELSE 0
     END AS exclude_flag
   FROM idq_production_idq_results.check_rule_by_scope_current_1 AS CRCS
    INNER JOIN idq_production_idq_results.ref_test_object_type_extended_1 AS TOTE ON CRCS.test_object_type_id = TOTE.id
    INNER JOIN idq_production_idq_results.ref_rule_1 AS RR ON CRCS.rule_id = RR.id
    LEFT JOIN idq_production_idq_results.ref_exclude_1 AS RE_1 ON TOTE.level_1_id = RE.test_object_type_id AND CRCS.branch_id
            = RE.branch_id AND CRCS.country_id = RE.country_id AND CRCS.rule_id = RE.rule_id AND CRCS.source_system_id =
        RE.source_system_id AND RE.source_system_primary_key IS NULL AND RE.undone_at IS NULL
   UNION ALL
   SELECT CRCS.calculation_time AS check_rule_by_country_calculation_time,
    CRCS.calculation_day_id AS ref_time_calculation_day_id,
    CRCS.source_system_id AS ref_source_system_id,
    CRCS.branch_id AS ref_branch_id,
    CRCS.country_id AS ref_country_id,
    CRCS.source_system_type_id AS ref_source_system_type_id,
    CRCS.test_object_type_id AS ref_test_object_type_id,
    CRCS.rule_id AS ref_rule_id,
    RR.field_id AS ref_field_id,
    RR.criticality_id AS ref_criticality_id,
    RR.dimension_id AS ref_dimension_id,
    CRCS.test_result_amount,
    CRCS.error_amount,
    CRCS.no_error_amount,
    CRCS.solved_error_amount,
    CRCS.new_error_amount,
    CRCS.flip_error_amount,
    CRCS.earliest_due_date,
    CRCS.earliest_due_day_id AS ref_time_earliest_due_day_id,
    CRCS.overdue_amount,
    CRCS.status_id AS ref_status_id,
    0 AS check_rule_by_country_is_current,
    CRCS.newly_solved_error_amount,
     CASE
     WHEN RE.exclude_flag IS NOT NULL
     THEN RE.exclude_flag
     ELSE 0
     END AS exclude_flag
   FROM idq_production_idq_results.check_rule_by_scope_historical_1 AS CRCS
    INNER JOIN idq_production_idq_results.ref_test_object_type_extended_1 AS TOTE ON CRCS.test_object_type_id = TOTE.id
    INNER JOIN idq_production_idq_results.ref_rule_1 AS RR ON CRCS.rule_id = RR.id
    LEFT JOIN idq_production_idq_results.ref_exclude_1 AS RE_1 ON TOTE.level_1_id = RE.test_object_type_id AND CRCS.branch_id
            = RE.branch_id AND CRCS.country_id = RE.country_id AND CRCS.rule_id = RE.rule_id AND CRCS.source_system_id =
        RE.source_system_id AND RE.source_system_primary_key IS NULL AND RE.undone_at IS NULL) AS COUNTRY_SUMMARY;