CREATE OR REPLACE VIEW idq_production_dwh.idq_test_object_leading (leading_idq_test_object_id, ref_branch_id,
source_system_primary_key, ref_source_system_id, ldo_num, ref_country_id, name, ref_test_object_type_id,
source_system_status, is_relevant, first_unsuccessful_load, ref_time_first_unsuccessful_load_day_id,
ref_source_system_type_id, idq_test_object_calculation_time, ref_time_calculation_day_id, penalty, score, field_amount,
is_usable, leading_functional_id) AS SELECT DISTINCT ito.id AS leading_idq_test_object_id,
 ito.branch_id AS ref_branch_id,
 ito.source_system_primary_key,
 ito.source_system_id AS ref_source_system_id,
 ito.ldo_num,
 ito.country_id AS ref_country_id,
 ito.name,
 ito.test_object_type_id AS ref_test_object_type_id,
 ito.source_system_status,
 ito.is_relevant,
 ito.first_unsuccessful_load,
 ito.first_unsuccessful_load_day_id AS ref_time_first_unsuccessful_load_day_id,
 rss.source_system_type_id AS ref_source_system_type_id,
 cdto.calculation_time AS idq_test_object_calculation_time,
 cdto.calculation_day_id AS ref_time_calculation_day_id,
 cdto.penalty,
 cdto.score,
 cdto.field_amount,
 cdto.is_usable,
  CASE
  WHEN ito.functional_id IS NULL
  THEN ito.source_system_primary_key
  ELSE ito.functional_id
  END AS leading_functional_id
FROM idq_production_idq_results.idq_test_object AS ito
 INNER JOIN idq_production_idq_results.ref_source_system AS rss ON ito.source_system_id = rss.id
 LEFT JOIN idq_production_idq_results.check_dq_by_test_object_current AS cdto ON ito.id = cdto.test_object_id
 LEFT JOIN idq_production_syscomp.comp_record_list AS crl ON ito.id = crl.leading_test_object_id
 LEFT JOIN idq_production_syscomp.comp_field_result_current AS cfr ON ito.id = cfr.leading_test_object_id
WHERE crl.matching_status_id > 1
 OR cfr.is_error_detected = 1;