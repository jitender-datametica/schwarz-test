CREATE OR REPLACE VIEW idq_production_dwh.reporting_test_result_2 (reporting_test_result_id, idq_test_object_id,
ref_rule_id, in_report_included, first_include, first_exclude, ref_time_first_include_day_id,
ref_time_first_exclude_day_id, ref_field_id, ref_source_system_type_id, ref_branch_id, ref_country_id,
ref_test_object_type_id, ref_dimension_id, ref_source_system_id) AS SELECT ROW_NUMBER() OVER (ORDER BY RTR.first_include_day_id
    IS NULL, RTR.first_include_day_id, RTR.test_object_id IS NULL, RTR.test_object_id, RTR.rule_id IS NULL, RTR.rule_id
  ) AS reporting_test_result_id,
 RTR.test_object_id AS idq_test_object_id,
 RTR.rule_id AS ref_rule_id,
 RTR.in_report_included,
 RTR.first_include,
 RTR.first_exclude,
 RTR.first_include_day_id AS ref_time_first_include_day_id,
 RTR.first_exclude_day_id AS ref_time_first_exclude_day_id,
 RR.field_id AS ref_field_id,
 RSS.source_system_type_id AS ref_source_system_type_id,
 ITO.branch_id AS ref_branch_id,
 ITO.country_id AS ref_country_id,
 ITO.test_object_type_id AS ref_test_object_type_id,
 RR.dimension_id AS ref_dimension_id,
 ITO.source_system_id AS ref_source_system_id
FROM idq_production_idq_results.reporting_test_result_current_2 AS RTR
 INNER JOIN idq_production_idq_results.ref_rule_2 AS RR ON RTR.rule_id = RR.id
 INNER JOIN idq_production_idq_results.idq_test_object_2 AS ITO ON RTR.test_object_id = ITO.id
 INNER JOIN idq_production_idq_results.ref_source_system_2 AS RSS ON ITO.source_system_id = RSS.id;