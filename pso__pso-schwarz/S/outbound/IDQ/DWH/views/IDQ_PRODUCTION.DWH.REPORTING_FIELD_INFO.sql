CREATE OR REPLACE VIEW idq_production_dwh.reporting_field_info (reporting_field_info_id, reporting_test_result_id,
idq_test_object_id, ref_rule_id, additional_info, additional_info_de, additional_info_en, ref_source_system_type_id,
ref_branch_id, ref_country_id, ref_test_object_type_id, ref_dimension_id, ref_source_system_id) AS SELECT 10000 * CAST(RFI.test_object_id AS BIGNUMERIC)
    + RFI.rule_id AS reporting_field_info_id,
 RTR.reporting_test_result_id,
 RFI.test_object_id AS idq_test_object_id,
 RFI.rule_id AS ref_rule_id,
 RFI.additional_info_de AS additional_info,
 RFI.additional_info_de,
 RFI.additional_info_en,
 RSS.source_system_type_id AS ref_source_system_type_id,
 ITO.branch_id AS ref_branch_id,
 ITO.country_id AS ref_country_id,
 ITO.test_object_type_id AS ref_test_object_type_id,
 RR.dimension_id AS ref_dimension_id,
 ITO.source_system_id AS ref_source_system_id
FROM idq_production_idq_results.reporting_dq_by_field_current AS RFI
 INNER JOIN idq_production_dwh.reporting_test_result AS RTR ON RFI.test_object_id = RTR.idq_test_object_id AND RFI.rule_id
    = RTR.ref_rule_id
 INNER JOIN idq_production_idq_results.idq_test_object AS ITO ON RFI.test_object_id = ITO.id
 INNER JOIN idq_production_idq_results.ref_source_system AS RSS ON ITO.source_system_id = RSS.id
 INNER JOIN idq_production_idq_results.ref_rule AS RR ON RFI.rule_id = RR.id;