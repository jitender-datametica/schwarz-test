CREATE OR REPLACE VIEW idq_production_dwh.relevance_execution_1 (relevance_execution_id,
relevance_execution_calculation_time, ref_relevance_definition_id, ref_source_system_id, ref_country_id,
ref_source_system_type_id, ref_branch_id, ref_test_object_type_id) AS SELECT RE.id AS relevance_execution_id,
 RE.test_time AS relevance_execution_calculation_time,
 RE.relevance_definition_id AS ref_relevance_definition_id,
 RE.source_system_id AS ref_source_system_id,
 RE.country_id AS ref_country_id,
 RD.source_system_type_id AS ref_source_system_type_id,
 RD.branch_id AS ref_branch_id,
 RD.test_object_type_id AS ref_test_object_type_id
FROM idq_production_idq_results.relevance_execution_1 AS RE_1
 INNER JOIN idq_production_idq_results.ref_relevance_definition_1 AS RD ON RE.relevance_definition_id = RD.id;