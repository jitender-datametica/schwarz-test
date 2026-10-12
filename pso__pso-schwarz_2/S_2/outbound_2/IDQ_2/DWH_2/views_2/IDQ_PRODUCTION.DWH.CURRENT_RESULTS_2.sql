CREATE OR REPLACE VIEW idq_production_dwh.current_results_2 (calculation_time, calculation_id, rule_id, rule_name,
test_result_amount, error_amount, surce_system_name, branch_name, country_2, source_system_type_name, test_object_type,
rule_technical_name, source_table, field_name, criticality_name, dimension_name) AS SELECT CH.check_rule_by_country_calculation_time
  AS calculation_time,
 CH.ref_time_calculation_day_id AS calculation_id,
 R.ref_rule_id AS rule_id,
 R.rule_technical_name AS rule_name,
 CH.test_result_amount,
 CH.error_amount,
 SS.source_system_name AS surce_system_name,
 B.branch_name,
 C.country_2,
 SST.source_system_type_name,
 TOT.test_object_type_technical_name AS test_object_type,
 R.rule_technical_name,
 F.source_table,
 F.field_name,
 CR.criticality_name,
 D.dimension_name
FROM idq_production_dwh.check_rule_by_country_summary_2 AS CH
 INNER JOIN idq_production_dwh.ref_source_system_2 AS SS ON CH.ref_source_system_id = SS.ref_source_system_id
 INNER JOIN idq_production_dwh.ref_branch_2 AS B ON CH.ref_branch_id = B.ref_branch_id
 INNER JOIN idq_production_dwh.ref_country_2 AS C ON CH.ref_country_id = C.ref_country_id
 INNER JOIN idq_production_dwh.ref_source_system_type_2 AS SST ON CH.ref_source_system_type_id = SST.ref_source_system_type_id
  
 INNER JOIN idq_production_dwh.ref_test_object_type_2 AS TOT ON CH.ref_test_object_type_id = TOT.ref_test_object_type_id
 INNER JOIN idq_production_dwh.ref_rule_2 AS R ON CH.ref_rule_id = R.ref_rule_id
 INNER JOIN idq_production_dwh.ref_field_2 AS F ON CH.ref_field_id = F.ref_field_id
 INNER JOIN idq_production_dwh.ref_criticality_2 AS CR ON CH.ref_criticality_id = CR.ref_criticality_id
 INNER JOIN idq_production_dwh.ref_dimension_2 AS D ON CH.ref_dimension_id = D.ref_dimension_id;