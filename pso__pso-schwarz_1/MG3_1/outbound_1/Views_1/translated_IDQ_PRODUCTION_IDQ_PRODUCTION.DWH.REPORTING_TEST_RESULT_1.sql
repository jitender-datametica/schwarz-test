CREATE OR REPLACE VIEW idq_production_dwh.reporting_test_result_1 (reporting_test_result_id, idq_test_object_id,
ref_rule_id, in_report_included, first_include, first_exclude, ref_time_first_include_day_id,
ref_time_first_exclude_day_id, ref_field_id, ref_source_system_type_id, ref_branch_id, ref_country_id,
ref_test_object_type_id, ref_dimension_id, ref_source_system_id) AS SELECT ROW_NUMBER() OVER (ORDER BY rtr.first_include_day_id
    IS NULL, rtr.first_include_day_id, rtr.test_object_id IS NULL, rtr.test_object_id, rtr.rule_id IS NULL, rtr.rule_id
  ) AS reporting_test_result_id,
 rtr.test_object_id AS idq_test_object_id,
 rtr.rule_id AS ref_rule_id,
 rtr.in_report_included,
 rtr.first_include,
 rtr.first_exclude,
 rtr.first_include_day_id AS ref_time_first_include_day_id,
 rtr.first_exclude_day_id AS ref_time_first_exclude_day_id,
 rr.field_id AS ref_field_id,
 rss.source_system_type_id AS ref_source_system_type_id,
 ito.branch_id AS ref_branch_id,
 ito.country_id AS ref_country_id,
 ito.test_object_type_id AS ref_test_object_type_id,
 rr.dimension_id AS ref_dimension_id,
 ito.source_system_id AS ref_source_system_id
FROM idq_production_idq_results.reporting_test_result_current_1 AS rtr
 INNER JOIN idq_production_idq_results.ref_rule_1 AS rr ON rtr.rule_id = rr.id
 INNER JOIN idq_production_idq_results.idq_test_object_1 AS ito ON rtr.test_object_id = ito.id
 INNER JOIN idq_production_idq_results.ref_source_system_1 AS rss ON ito.source_system_id = rss.id;