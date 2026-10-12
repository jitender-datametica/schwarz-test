CREATE OR REPLACE VIEW idq_production_dwh.reporting_field_info (reporting_field_info_id, reporting_test_result_id,
idq_test_object_id, ref_rule_id, additional_info, additional_info_de, additional_info_en, ref_source_system_type_id,
ref_branch_id, ref_country_id, ref_test_object_type_id, ref_dimension_id, ref_source_system_id) AS SELECT 10000 * CAST(rfi.test_object_id AS BIGNUMERIC)
    + rfi.rule_id AS reporting_field_info_id,
 rtr.reporting_test_result_id,
 rfi.test_object_id AS idq_test_object_id,
 rfi.rule_id AS ref_rule_id,
 rfi.additional_info_de AS additional_info,
 rfi.additional_info_de,
 rfi.additional_info_en,
 rss.source_system_type_id AS ref_source_system_type_id,
 ito.branch_id AS ref_branch_id,
 ito.country_id AS ref_country_id,
 ito.test_object_type_id AS ref_test_object_type_id,
 rr.dimension_id AS ref_dimension_id,
 ito.source_system_id AS ref_source_system_id
FROM idq_production_idq_results.reporting_dq_by_field_current AS rfi
 INNER JOIN idq_production_dwh.reporting_test_result AS rtr ON rfi.test_object_id = rtr.idq_test_object_id AND rfi.rule_id
    = rtr.ref_rule_id
 INNER JOIN idq_production_idq_results.idq_test_object AS ito ON rfi.test_object_id = ito.id
 INNER JOIN idq_production_idq_results.ref_source_system AS rss ON ito.source_system_id = rss.id
 INNER JOIN idq_production_idq_results.ref_rule AS rr ON rfi.rule_id = rr.id;