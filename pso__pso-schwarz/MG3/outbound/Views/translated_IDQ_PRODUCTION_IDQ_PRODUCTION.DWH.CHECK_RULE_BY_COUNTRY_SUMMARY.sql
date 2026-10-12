CREATE OR REPLACE VIEW idq_production_dwh.check_rule_by_country_summary (check_rule_by_country_summary_id,
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
FROM (SELECT crcs.calculation_time AS check_rule_by_country_calculation_time,
    crcs.calculation_day_id AS ref_time_calculation_day_id,
    crcs.source_system_id AS ref_source_system_id,
    crcs.branch_id AS ref_branch_id,
    crcs.country_id AS ref_country_id,
    crcs.source_system_type_id AS ref_source_system_type_id,
    crcs.test_object_type_id AS ref_test_object_type_id,
    crcs.rule_id AS ref_rule_id,
    rr.field_id AS ref_field_id,
    rr.criticality_id AS ref_criticality_id,
    rr.dimension_id AS ref_dimension_id,
    crcs.test_result_amount,
    crcs.error_amount,
    crcs.no_error_amount,
    crcs.solved_error_amount,
    crcs.new_error_amount,
    crcs.flip_error_amount,
    crcs.earliest_due_date,
    crcs.earliest_due_day_id AS ref_time_earliest_due_day_id,
    crcs.overdue_amount,
    crcs.status_id AS ref_status_id,
    1 AS check_rule_by_country_is_current,
    crcs.newly_solved_error_amount,
     CASE
     WHEN re.exclude_flag IS NOT NULL
     THEN re.exclude_flag
     ELSE 0
     END AS exclude_flag
   FROM idq_production_idq_results.check_rule_by_scope_current AS crcs
    INNER JOIN idq_production_idq_results.ref_test_object_type_extended AS tote ON crcs.test_object_type_id = tote.id
    INNER JOIN idq_production_idq_results.ref_rule AS rr ON crcs.rule_id = rr.id
    LEFT JOIN idq_production_idq_results.ref_exclude AS re ON tote.level_1_id = re.test_object_type_id AND crcs.branch_id
            = re.branch_id AND crcs.country_id = re.country_id AND crcs.rule_id = re.rule_id AND crcs.source_system_id =
        re.source_system_id AND re.source_system_primary_key IS NULL AND re.undone_at IS NULL
   UNION ALL
   SELECT crcs.calculation_time AS check_rule_by_country_calculation_time,
    crcs.calculation_day_id AS ref_time_calculation_day_id,
    crcs.source_system_id AS ref_source_system_id,
    crcs.branch_id AS ref_branch_id,
    crcs.country_id AS ref_country_id,
    crcs.source_system_type_id AS ref_source_system_type_id,
    crcs.test_object_type_id AS ref_test_object_type_id,
    crcs.rule_id AS ref_rule_id,
    rr.field_id AS ref_field_id,
    rr.criticality_id AS ref_criticality_id,
    rr.dimension_id AS ref_dimension_id,
    crcs.test_result_amount,
    crcs.error_amount,
    crcs.no_error_amount,
    crcs.solved_error_amount,
    crcs.new_error_amount,
    crcs.flip_error_amount,
    crcs.earliest_due_date,
    crcs.earliest_due_day_id AS ref_time_earliest_due_day_id,
    crcs.overdue_amount,
    crcs.status_id AS ref_status_id,
    0 AS check_rule_by_country_is_current,
    crcs.newly_solved_error_amount,
     CASE
     WHEN re.exclude_flag IS NOT NULL
     THEN re.exclude_flag
     ELSE 0
     END AS exclude_flag
   FROM idq_production_idq_results.check_rule_by_scope_historical AS crcs
    INNER JOIN idq_production_idq_results.ref_test_object_type_extended AS tote ON crcs.test_object_type_id = tote.id
    INNER JOIN idq_production_idq_results.ref_rule AS rr ON crcs.rule_id = rr.id
    LEFT JOIN idq_production_idq_results.ref_exclude AS re ON tote.level_1_id = re.test_object_type_id AND crcs.branch_id
            = re.branch_id AND crcs.country_id = re.country_id AND crcs.rule_id = re.rule_id AND crcs.source_system_id =
        re.source_system_id AND re.source_system_primary_key IS NULL AND re.undone_at IS NULL) AS COUNTRY_SUMMARY;