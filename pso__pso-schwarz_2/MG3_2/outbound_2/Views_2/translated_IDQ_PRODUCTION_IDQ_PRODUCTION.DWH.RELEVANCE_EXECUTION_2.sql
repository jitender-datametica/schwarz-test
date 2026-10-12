CREATE OR REPLACE VIEW idq_production_dwh.relevance_execution_2 (relevance_execution_id,
relevance_execution_calculation_time, ref_relevance_definition_id, ref_source_system_id, ref_country_id,
ref_source_system_type_id, ref_branch_id, ref_test_object_type_id) AS SELECT re.id AS relevance_execution_id,
 re.test_time AS relevance_execution_calculation_time,
 re.relevance_definition_id AS ref_relevance_definition_id,
 re.source_system_id AS ref_source_system_id,
 re.country_id AS ref_country_id,
 rd.source_system_type_id AS ref_source_system_type_id,
 rd.branch_id AS ref_branch_id,
 rd.test_object_type_id AS ref_test_object_type_id
FROM idq_production_idq_results.relevance_execution_2 AS re_2
 INNER JOIN idq_production_idq_results.ref_relevance_definition_2 AS rd ON re.relevance_definition_id = rd.id;